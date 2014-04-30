From: Alexander Stein <alexanders83@web.de>
Subject: devicetree based AC97 driver
Date: Wed, 30 Apr 2014 22:20:41 +0200
Message-ID: <6120526.NBrCDfnQNi@kongar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C4FB265253
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 22:20:47 +0200 (CEST)
Received: from kongar.localnet ([77.64.221.251]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MI6JC-1WjRHE3Cb0-003t56 for
 <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 22:20:46 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

some might remember me posting some patches to (old) Atmel AC97 controller driver for device tree support.
It was suggested to switch over to ASoC. I started doing this to get full devicetree support for my at91sam9263 board which has a codec attached to the AC97 lines. Until now I failed because the terminology is confusing me. I also stumbled over the documentation of those machine drivers. Do I really need some board-specific code in order to get all this working? This would make the devicetree approach rather useless.
So what would I need to get this working? I guess a new snd_soc_codec_driver for LM4550B using soc_ac97_ops for accessing the registers. I suppose a new snd_soc_dai_ops for the actual Atmel AC97 controller. Anything else?
Which part creates the sound card in ALSA itself?

Best regards,
Alexander
