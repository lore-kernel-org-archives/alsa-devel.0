From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 00:22:41 -0300
Message-ID: <CAOMZO5BwZnhR=Fa3VaCEFTQGso9US3jSYXi5EzQjG35MP23k4g@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A4900265E2D
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 04:52:56 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so6228865obb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 20:22:41 -0700 (PDT)
In-Reply-To: <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Tabi Timur-B04825 <B04825@freescale.com>, kernel@pengutronix.de, =?UTF-8?Q?Ga=C3=ABtan_Carlier?= <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 6:49 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Aug 6, 2012 at 4:58 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Ok, understood.
>>
>> Sascha,
>>
>> Do you know if mono playback used to work previously in imx-ssi?
>
> Ok, just tested a mono track on a mx6qsabrelite and it played well.

Ops, I was making a confusion:

mx6sabrelite runs a dt kernel and uses fsl_ssi.c driver.

mx31pdk runs a non-dt kernel and uses imx-ssi.c driver.

The fsl_ssi.c code has:

	.playback = {
		/* The SSI does not support monaural audio. */
		.channels_min = 2,
		.channels_max = 2,
		.rates = FSLSSI_I2S_RATES,
		.formats = FSLSSI_I2S_FORMATS,
	},

and if I do the same on imx-ssi.c, ie, change 'channels_min' to 2,
then it also plays correctly.

So is my original patch correct? Maybe I should change the wording of
the commit log?

Thanks,

Fabio Estevam
