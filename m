From: Fabio Estevam <festevam@gmail.com>
Subject: Failed to set cache compression type
Date: Mon, 2 Jun 2014 10:43:48 -0300
Message-ID: <CAOMZO5Cj=qrrH_nWhCM4-63GPqfgpL1k=Q53z8cDDk3_TpUzBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 555E32651F3
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 15:43:49 +0200 (CEST)
Received: by mail-vc0-f177.google.com with SMTP id hy4so2155094vcb.22
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 06:43:48 -0700 (PDT)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I am booting linux-next 20140602 on a mx6qsabresd and I get the following probe
error:

wm8962 0-001a: customer id 0 revision D
wm8962 0-001a: ASoC: Failed to set cache compression type: -22
imx-wm8962 sound: snd_soc_register_card failed (-22)
imx-wm8962: probe of sound failed with error -22

What is the proper way to fix it?

Thanks,

Fabio Estevam
