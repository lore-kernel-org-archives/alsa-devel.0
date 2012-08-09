From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v8] media: Add stk1160 new driver
Date: Thu, 09 Aug 2012 17:25:50 -0300
Message-ID: <50241CCE.2030000@redhat.com>
References: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5DB266410
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 21:56:08 +0200 (CEST)
In-Reply-To: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, alsa-devel@alsa-project.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Patch looks ok. Just a few comments:

Em 06-08-2012 10:38, Ezequiel Garcia escreveu:
> This driver adds support for stk1160 usb bridge as used in some
> video/audio usb capture devices.
> It is a complete rewrite of staging/media/easycap driver and
> it's expected as a replacement.
> ---

Please don't add a "---" here. Everything after a --- are discarded
by my scripts (and by most other kernel developer scripts).

> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Hmm... weren't it reviewed already be them?

> Signed-off-by: Ezequiel Garcia <elezegarcia@gmail.com>
> diff --git a/drivers/media/video/stk1160/Makefile b/drivers/media/video/stk1160/Makefile
> new file mode 100644
> index 0000000..8f66a78
> --- /dev/null
> +++ b/drivers/media/video/stk1160/Makefile
> @@ -0,0 +1,12 @@
> +obj-stk1160-ac97-$(CONFIG_VIDEO_STK1160_AC97) := stk1160-ac97.o
> +
> +stk1160-y := 	stk1160-core.o \
> +		stk1160-v4l.o \
> +		stk1160-video.o \
> +		stk1160-i2c.o \
> +		$(obj-stk1160-ac97-y)
> +
> +obj-$(CONFIG_VIDEO_STK1160) += stk1160.o
> +
> +ccflags-y += -Wall

You shouldn't be adding the above here.

> +ccflags-y += -Idrivers/media/video

Ah, please split this patch into two patches: one with the new driver
addition, and another one with the removal of the driver at staging.

That will help to make the patch smaller, and avoids mixing two different
things at the same place.

Thanks,
Mauro
