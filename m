From: Dave Airlie <airlied@gmail.com>
Subject: Re: regression in device count on hotplug
Date: Tue, 9 Jun 2015 13:40:00 +1000
Message-ID: <CAPM=9txKmq4i0Kb8hZ3QJfLpH-_Q4UHg1z=Ob5XX3ZB3tNUb7w@mail.gmail.com>
References: <CAPM=9txvcgQ9YcMkC2mNrZWhESPtwXREhr-Abjgjw+ftHsPd1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 48CE6261B36
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 05:40:01 +0200 (CEST)
Received: by laar3 with SMTP id r3so3682874laa.3
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2015 20:40:00 -0700 (PDT)
In-Reply-To: <CAPM=9txvcgQ9YcMkC2mNrZWhESPtwXREhr-Abjgjw+ftHsPd1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

On 9 June 2015 at 12:53, Dave Airlie <airlied@gmail.com> wrote:
> Hi,
>
> I've been looking at mst support a bit more, and noticed a regression
> in the number of devices probing between 4.0 and 4.1
>
> On 4.0 if I boot with no dock, and cat /proc/asound/HDMI/codec#0
>
> Node 0x06 has Devices: 0
> if I dock
> I get
> Devices: 3, and the info about the 3 devices.
>
> On 4.1-rc6 if I boot with no dock, and cat
> I get Devices:0,
> however when I dock,
> I still get Devices: 0
>
> I haven't had time to bisect yet, but was hoping someone might be able
> to spot it from the symptoms.

Okay I've found a fix.

patch sent to alsa-devel.

Dave.
