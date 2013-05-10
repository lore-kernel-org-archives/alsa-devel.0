From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 1/5] DAISY-I2S: add Samsung ARM Chromebook UCM
	config from ChromeOS
Date: Fri, 10 May 2013 14:51:06 +0200
Message-ID: <1368190270-29647-2-git-send-email-marcin@juszkiewicz.com.pl>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tygrysek.juszkiewicz.com.pl (tygrysek.juszkiewicz.com.pl
 [178.33.81.99]) by alsa0.perex.cz (Postfix) with ESMTP id 327352615ED
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 14:51:20 +0200 (CEST)
In-Reply-To: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
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
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 DAISY-I2S/DAISY-I2S.conf |  6 +++++
 DAISY-I2S/HiFi.conf      | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 DAISY-I2S/DAISY-I2S.conf
 create mode 100644 DAISY-I2S/HiFi.conf

diff --git a/DAISY-I2S/DAISY-I2S.conf b/DAISY-I2S/DAISY-I2S.conf
new file mode 100644
index 0000000..0f4b5fc
--- /dev/null
+++ b/DAISY-I2S/DAISY-I2S.conf
@@ -0,0 +1,6 @@
+Comment "Daisy internal card"
+
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Default"
+}
diff --git a/DAISY-I2S/HiFi.conf b/DAISY-I2S/HiFi.conf
new file mode 100644
index 0000000..66b0afa
--- /dev/null
+++ b/DAISY-I2S/HiFi.conf
@@ -0,0 +1,61 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:DAISYI2S"
+		cset "name='Left Speaker Mixer Left DAC1 Switch' on"
+		cset "name='Right Speaker Mixer Right DAC1 Switch' on"
+		cset "name='Left Headphone Mixer Left DAC1 Switch' on"
+		cset "name='Right Headphone Mixer Right DAC1 Switch' on"
+		cset "name='DMIC1 Left Capture Switch' on"
+		cset "name='DMIC1 Right Capture Switch' on"
+		cset "name='MIC2 External Mic Switch' on"
+		cset "name='Left ADC Mixer MIC2 Switch' on"
+		cset "name='Right ADC Mixer MIC2 Switch' on"
+		cset "name='EQ1 Mode' Default"
+	]
+	DisableSequence [
+	]
+}
+
+SectionDevice."Headphone".0 {
+	Value {
+		JackName "DAISY-I2S Headphone Jack"
+	}
+
+	EnableSequence [
+		cdev "hw:DAISYI2S"
+		cset "name='EQ1 Switch' off"
+		cset "name='Left Headphone Mixer Left DAC1 Switch' on"
+		cset "name='Right Headphone Mixer Right DAC1 Switch' on"
+	]
+	DisableSequence [
+		cdev "hw:DAISYI2S"
+		cset "name='EQ1 Mode' Default"
+		cset "name='EQ1 Switch' on"
+		cset "name='Left Speaker Mixer Left DAC1 Switch' on"
+		cset "name='Right Speaker Mixer Right DAC1 Switch' on"
+	]
+}
+
+SectionDevice."Mic".0 {
+	Value {
+		JackName "DAISY-I2S Mic Jack"
+	}
+
+	EnableSequence [
+		cdev "hw:DAISYI2S"
+
+		cset "name='DMIC1 Left Capture Switch' off"
+		cset "name='DMIC1 Right Capture Switch' off"
+		cset "name='Left ADC Mixer MIC2 Switch' on"
+		cset "name='Right ADC Mixer MIC2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:DAISYI2S"
+
+		cset "name='Left ADC Mixer MIC2 Switch' off"
+		cset "name='Right ADC Mixer MIC2 Switch' off"
+		cset "name='DMIC1 Left Capture Switch' on"
+		cset "name='DMIC1 Right Capture Switch' on"
+	]
+}
-- 
1.8.1.2
