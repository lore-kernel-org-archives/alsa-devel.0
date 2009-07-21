From: javier Martin <javier.martin@vista-silicon.com>
Subject: ASoC: Correct a bug with "ADC Inversion Switch" in
	wm8974 codec.
Date: Tue, 21 Jul 2009 11:15:06 +0200
Message-ID: <eedb5540907210215s620537cciaf5e5bd5cdee74c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f222.google.com (mail-ew0-f222.google.com
	[209.85.219.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 077B124392
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 11:15:08 +0200 (CEST)
Received: by ewy22 with SMTP id 22so2955169ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2009 02:15:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This corrects a bug with ADC Inversion Switch in wm8974 codec.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

---
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index f26c8d0..38a0c44 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -162,7 +162,7 @@ SOC_SINGLE_TLV("PCM Volume", WM8974_DACVOL, 0,
255, 0, digital_tlv),

 SOC_SINGLE("High Pass Filter Switch", WM8974_ADC, 8, 1, 0),
 SOC_SINGLE("High Pass Cut Off", WM8974_ADC, 4, 7, 0),
-SOC_SINGLE("ADC Inversion Switch", WM8974_COMP, 0, 1, 0),
+SOC_SINGLE("ADC Inversion Switch", WM8974_ADC, 0, 1, 0),

 SOC_SINGLE_TLV("Capture Volume", WM8974_ADCVOL,  0, 255, 0, digital_tlv),

-- 
Javier Martin
Vista Silicon S.L.
Universidad de Cantabria
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
