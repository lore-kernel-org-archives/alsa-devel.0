From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: Re: SoC/Codecs/SGTL5000 - Non working MIC_BIAS Voltage
	settings
Date: Wed, 17 Jun 2015 09:20:06 +0200
Message-ID: <55811FA6.4050408@eurekelettronica.it>
References: <557B0528.2060404@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx7.acantho.net (mx7.acantho.net [213.174.182.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 19B1E265AD5
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 09:20:20 +0200 (CEST)
Received: (from root@localhost)
 by mx7.acantho.net (8.14.3/8.13.4/Debian-3sarge1) id t5H7KJjH005870
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 09:20:19 +0200
In-Reply-To: <557B0528.2060404@eurekelettronica.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello,
I didn't receive any feedback about this posting...

On 06/12/2015 06:13 PM, gianluca wrote:
> Hello,
> in attachment there is a small patch to ensure the correct register
> value for MIC BIAS Voltage.

diff -Nru linux-4.0.5.orig/sound/soc/codecs/sgtl5000.c 
linux-4.0.5/sound/soc/codecs/sgtl5000.c
--- linux-4.0.5.orig/sound/soc/codecs/sgtl5000.c	2015-06-06 
17:21:22.000000000 +0200
+++ linux-4.0.5/sound/soc/codecs/sgtl5000.c	2015-06-12 
18:09:38.363381087 +0200
@@ -1339,8 +1339,8 @@
  			sgtl5000->micbias_resistor << SGTL5000_BIAS_R_SHIFT);

  	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
-			SGTL5000_BIAS_R_MASK,
-			sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
+			SGTL5000_BIAS_VOLT_MASK,
+			sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
  	/*
  	 * disable DAP
  	 * TODO:


-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
