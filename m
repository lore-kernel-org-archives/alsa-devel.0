From: Fabio Estevam <festevam@gmail.com>
Subject: ASoC: Failed to create DAPM debugfs
Date: Wed, 8 Apr 2015 15:31:44 -0300
Message-ID: <CAOMZO5DP4fahmC9W6eBFdjxR1DqPMgyhgwxwSZP_TcqxLSy=7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4650C2606CB
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 20:31:45 +0200 (CEST)
Received: by layy10 with SMTP id y10so72650157lay.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 11:31:44 -0700 (PDT)
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On a imx6q-hummingboard the following warning is seen when running
linux-next 20150408:

[    2.270006] imx-spdif sound-spdif: ASoC: Failed to create DAPM
debugfs directory

Looking at sound/soc/fsl/imx-spdif.c and sound/soc/fsl/fsl_spdif.c I
am not sure how to avoid such warning.

Any ideas?

Thanks,

Fabio Estevam
