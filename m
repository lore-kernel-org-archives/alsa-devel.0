From: Fabio Estevam <festevam@gmail.com>
Subject: ASoC: no dapm match for AMIC
Date: Tue, 4 Nov 2014 09:48:25 -0200
Message-ID: <CAOMZO5BUx+mhhELKJw5S8jBMJGHP5wMW5A0kwNAScbOmHMvbUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 9198126060B
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:48:26 +0100 (CET)
Received: by mail-la0-f46.google.com with SMTP id hs14so708707lab.5
 for <alsa-devel@alsa-project.org>; Tue, 04 Nov 2014 03:48:26 -0800 (PST)
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I am running linux-next 20141104 on a imx6q-sabresd board and noticed
the following error messages:

[    2.145602] imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
[    2.151654] imx-wm8962 sound: Connecting non-supply widget to
supply widget is not supported (AMIC -> MICBIAS)
[    2.161710] imx-wm8962 sound: ASoC: no dapm match for AMIC -->
(null) --> MICBIAS
[    2.169258] imx-wm8962 sound: ASoC: Failed to add route AMIC ->
direct -> MICBIAS

What would be the correct way to fix them?

Thanks
