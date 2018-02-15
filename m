From: Fabio Estevam <festevam@gmail.com>
Subject: sgtl5000 fails after suspend/resume
Date: Thu, 15 Feb 2018 11:35:18 -0200
Message-ID: <CAOMZO5B3rb_UKatssvP0eZdm4JD_oa3A0A1pAr4keq4w0EYBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f173.google.com (mail-ot0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 100352671AE
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 14:35:20 +0100 (CET)
Received: by mail-ot0-f173.google.com with SMTP id 73so23362991oti.12
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 05:35:20 -0800 (PST)
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
Cc: Eric Nelson <eric@nelint.com>, Stefan Agner <stefan@agner.ch>, Gary Bisson <gary.bisson@boundarydevices.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I noticed that sgtl5000 does not work after a suspend/resume cycle:

# aplay /media/a2002011001-e02.wav
Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:2051: write error: Input/output error

Tested several 4.16-rc1 (and also previous kernels like 4.4) and all
of them failed.

I think it worked in some point in time.

Tested on a imx53qsb and imx6 wandboard.

Does anyone have any suggestions?

Thanks,

Fabio Estevam
