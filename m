From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] sound/pci: supported cards update
Date: Wed, 13 Aug 2008 00:14:43 +0400
Message-ID: <20080812201443.GB12411@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F86D2444F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 22:14:48 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1442117fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 13:14:47 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

sound/pci: supported devices update


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/ice1712/delta.h |    1 +
 sound/pci/ice1712/wtm.c   |    2 +-
 sound/pci/intel8x0.c      |    6 ++++++
 sound/pci/intel8x0m.c     |    1 +
 4 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ice1712/delta.h b/sound/pci/ice1712/delta.h
index ea7116c..f7f14df 100644
--- a/sound/pci/ice1712/delta.h
+++ b/sound/pci/ice1712/delta.h
@@ -31,6 +31,7 @@
 		"{MidiMan M Audio,Delta DiO 2496},"\
 		"{MidiMan M Audio,Delta 66},"\
 		"{MidiMan M Audio,Delta 44},"\
+		"{MidiMan M Audio,Delta 410},"\
 		"{MidiMan M Audio,Audiophile 24/96},"\
 		"{Digigram,VX442},"\
 		"{Lionstracs,Mediastation},"
diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index a08d17c..784dfd4 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -508,7 +508,7 @@ struct snd_ice1712_card_info snd_vt1724_wtm_cards[] __devinitdata = {
 	{
 		.subvendor = VT1724_SUBDEVICE_WTM,
 		.name = "ESI Waveterminal 192M",
-		.model = "WT192M",
+		.model = "wt192m",
 		.chip_init = wtm_init,
 		.build_controls = wtm_add_controls,
 		.eeprom_size = sizeof(wtm_eeprom),
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 048d99e..a0c8492 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -59,6 +59,12 @@ MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
 		"{SiS,SI7012},"
 		"{NVidia,nForce Audio},"
 		"{NVidia,nForce2 Audio},"
+		"{NVidia,nForce3 Audio},"
+		"{NVidia,MCP04},"
+		"{NVidia,MCP501},"
+		"{NVidia,CK804},"
+		"{NVidia,CK8},"
+		"{NVidia,CK8S},"
 		"{AMD,AMD768},"
 		"{AMD,AMD8111},"
 	        "{ALI,M5455}}");
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index faf674e..cdb55c6 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -54,6 +54,7 @@ MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
 		"{NVidia,NForce2 Modem},"
 		"{NVidia,NForce2s Modem},"
 		"{NVidia,NForce3 Modem},"
+		"{AMD,AMD8111},"
 		"{AMD,AMD768}}");
 
 static int index = -2; /* Exclude the first card */
