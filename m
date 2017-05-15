From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: [PATCH] ASoC: utils: Add DT support
Date: Mon, 15 May 2017 10:41:43 +0200
Message-ID: <CAC3a_SCJU_pxNhJOyXdW8x8Eeso8bVV38PkfRL+cRzd+rOoO7Q@mail.gmail.com>
References: <1493712508-27919-1-git-send-email-vishalthanki@gmail.com>
 <20170514095651.jbk2fkea6th24yay@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0FC1266DD7
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:42:04 +0200 (CEST)
Received: by mail-qk0-f193.google.com with SMTP id y128so15906458qka.3
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 01:42:04 -0700 (PDT)
In-Reply-To: <20170514095651.jbk2fkea6th24yay@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, May 14, 2017 at 11:56 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 02, 2017 at 10:08:28AM +0200, Vishal Thanki wrote:
>> Add device tree support for the dummy codec
>> driver.
>
> Why would this be useful?  If the device is a dummy device for internal
> use obviously it doesn't actually exist which tends to suggest that it
> shouldn't be represented in the DT either as the DT should describe the
> hardware.

Thanks for you comments. Actually in our custom hardware, the codec is
not accessible/visible from kernel directly, rather additional MCU
controls and configures it. However MCU needs the I2S clocks and data
from kernel. So I am using I2S platform driver from Linux just to
configure I2S clocks, and registering a dummy codec driver to DAI link
in DT, so that codec can be instantiated and clocks can be enabled
from user-space ALSA utils while accessing this dummy codec. Please
suggest if there is any better way to achieve this kind of
configuration.

Thanks,
Vishal
