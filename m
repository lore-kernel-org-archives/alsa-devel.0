From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Wed, 19 Sep 2012 11:07:33 -0300
Message-ID: <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <50589DD7.8050409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B0AD62651CC
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 16:07:34 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so1027875obb.38
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 07:07:33 -0700 (PDT)
In-Reply-To: <50589DD7.8050409@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, javier.martin@vista-silicon.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2012 at 1:14 PM, Timur Tabi <timur@freescale.com> wrote:
> Fabio Estevam wrote:
>>
>> Can you please try to play a mono track on your PowerPC platform with these
>> series applied?
>
> I'm pretty sure this won't work.  The SSI is programmed to expect a left
> and right sample.  There is no code in fsl_ssi.c for checking the channel
> count and adjusting the hardware accordingly.  I don't see any code like
> that in imx-ssi.c either, so I don't even know how it's supposed to work.

It works for me on mx6qsabrelite.

However, in order to play the mono track at the correct rate I also need:

--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -938,7 +938,7 @@ static struct snd_soc_dai_driver sgtl5000_dai = {
        .name = "sgtl5000",
        .playback = {
                .stream_name = "Playback",
-               .channels_min = 1,
+               .channels_min = 2,
                .channels_max = 2,
                /*
                 * only support 8~48K + 96

I would like to understand when channels_min should be set to 1 or 2
in the platform driver (sound/soc/fsl/fsl_ssi.c in this case) or
inside the codec. Could anyone clarify this, please?

Currently we have:

channels_min=1 for imx-ssi.c (FSL BSP also does the same)
channels_min=2 for fsl_ssi.c

Which one is correct?

Adding Sascha, who originally used 'channels_min=1' for imx-ssi.c.

Regards,

Fabio Estevam
