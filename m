From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: samsung - Don't setup i2s if already
	active.
Date: Fri, 9 Nov 2012 12:05:53 -0800
Message-ID: <CAEUnVG5ntyaK862R3Tu6J3VHhZVM+wZR4XOL1LDzSX1b9FuF9g@mail.gmail.com>
References: <1352414816-9157-1-git-send-email-dgreid@chromium.org>
 <20121109160856.GM23807@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 347C92625F3
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 21:06:15 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id f14so1574441eaa.38
 for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2012 12:06:14 -0800 (PST)
In-Reply-To: <20121109160856.GM23807@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, sangsu4u.park@samsung.com, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, padma.v@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 9, 2012 at 8:08 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 08, 2012 at 02:46:56PM -0800, Dylan Reid wrote:
>> If the dai is already running when setup is called, skip setup.  Setting
>> up again caused set_sysclk to set rclk_srcrate to other->rclk_srcrate,
>> other would often be set to the default of 44.1.  Playing a 48k stream
>> then adding a 48k capture stream would lead to both streams set to 44.1
>> (The value of other->rclk_srcrate).
>
> This doesn't seem the obvious fix here - surely if the setup comes out
> with the wrong answer the configuration it was asked for doesn't match
> the configuration the device currently has and therefore we should
> return an error as the new stream will have an incorrect setup?

Thanks Mark, sorry I didn't explain this better.  It is getting the
correct answer.  However if the same format is requested for another
stream, startup will clear rclk_srcrate.  rclk_srcrate being cleared
causes i2s_set_fmt to call i2s_set_sysclk.  i2s_set_sysclk assumes it
should use the "other" setting for rclk_srcrate (because something is
active).

for example:

aplay -Dhw:0 some_48k_file.wav
followed by
arecord -Dhw:0 -f dat /tmp/foo.wav

both 48k streams, but when the arecord is started, the aplay will have
its rate set to what ever the unused secondary DAI is using
(initialized to 44.1).

>
> Really this driver should probably be being redone in terms of the DPCM
> code, it predates it and is a very simple case of it but it's in the
> same ballpark feature wise.

That looks promising, not only for this but for a few other issues.
I'll take investigate some more, thanks for the suggestion.

>
>> Similarly in shutdown, if either playback or capture is still active,
>> return instead of turning off the clocks.
>
> This seems sensible; another option is to do clk_enable() for both
> streams then let the clock framework refcount for us.
