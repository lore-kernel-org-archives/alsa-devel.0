From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 19:10:07 -0300
Message-ID: <CAOMZO5AsS2sxUdo1aKXvtwetTr1LB31W6aJBVnGuVGAHPXmuZQ@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
 <20120806220136.GE26698@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A884265DF8
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 23:40:22 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so5902925obb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 15:10:07 -0700 (PDT)
In-Reply-To: <20120806220136.GE26698@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 7:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Aug 06, 2012 at 06:49:04PM -0300, Fabio Estevam wrote:
>
>> So it seems the issue is mc13783 related then.
>
> Is the device using I2S?  I2S doesn't really support stero properly...

The format is:

#define FMT_SSI (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
		SND_SOC_DAIFMT_CBM_CFM)

In wm1133-ev1.c you did:

	/* TODO: The SSI driver should figure this out for us */
	switch (channels) {
	case 2:
		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
		break;
	case 1:
		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffe, 0xffffffe, 1, 0);
		break;
	default:
		return -EINVAL;
	}

Maybe I should do something similar in imx-mc13783?

Regards,

Fabio Estevam
