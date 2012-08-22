From: Fabio Estevam <festevam@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Wed, 22 Aug 2012 18:30:58 -0300
Message-ID: <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
 <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E1E91265230
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 23:30:59 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so110909obb.38
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 14:30:59 -0700 (PDT)
In-Reply-To: <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: George Stefan <stefan.george87@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 22, 2012 at 5:25 AM, George Stefan
<stefan.george87@gmail.com> wrote:

> aplay -l
>
> **** List of PLAYBACK Hardware Devices ****
>
> card 0: mxsevk [mxs-evk], device 0: cinterion pcm cinterion-0 []
>
>   Subdevices: 1/1
>
>   Subdevice #0: subdevice #0
>
>
> ~ # arecord -l
> **** List of CAPTURE Hardware Devices ****
> card 0: mxsevk [mxs-evk], device 0: cinterion pcm cinterion-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

Shouldn't this register as pcm cinterion-1 instead?

On mx28evk we have:

root@freescale ~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

and we register it as:

static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
	{
		.name		= "HiFi Tx",
		.stream_name	= "HiFi Playback",
		.codec_dai_name	= "sgtl5000",
		.codec_name	= "sgtl5000.0-000a",
		.cpu_dai_name	= "mxs-saif.0",
		.platform_name	= "mxs-saif.0",
		.ops		= &mxs_sgtl5000_hifi_ops,
	}, {
		.name		= "HiFi Rx",
		.stream_name	= "HiFi Capture",
		.codec_dai_name	= "sgtl5000",
		.codec_name	= "sgtl5000.0-000a",
		.cpu_dai_name	= "mxs-saif.1",
		.platform_name	= "mxs-saif.1",
		.ops		= &mxs_sgtl5000_hifi_ops,
	},
};

Regards,

Fabio Estevam
