From: nowymarluk@wp.pl
Subject: [[ALSA] PATCH - /pci/hda/patch_conexant.c 1/1]
	patch_conexant.c: cd pin added to mixer for benq r55 laptop,
Date: Sun, 20 Sep 2009 01:08:58 +0200
Message-ID: <1253401738-8258-1-git-send-email-nowymarluk@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (smtp.wp.pl [212.77.101.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA1D247F5
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 01:09:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: edoiks <nowymarluk@wp.pl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: edoiks <nowymarluk@wp.pl>


Signed-off-by: edoiks <nowymarluk@wp.pl>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index 9d899ed..700a430 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -687,6 +687,8 @@ static struct hda_input_mux cxt5045_capture_source_benq = {
 		{ "IntMic", 0x1 },
 		{ "ExtMic", 0x2 },
 		{ "LineIn", 0x3 },
+		{ "CD Pin", 0x4 },
+		{ "Mixer ", 0x0 },
 	}
 };
 
@@ -816,6 +818,14 @@ static struct snd_kcontrol_new cxt5045_benq_mixers[] = {
 	HDA_CODEC_VOLUME("Line In Playback Volume", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Line In Playback Switch", 0x17, 0x3, HDA_INPUT),
 
+	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1a, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Capture Switch", 0x1a, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Playback Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Playback Switch", 0x17, 0x3, HDA_INPUT),
+
+	HDA_CODEC_VOLUME("Mixer Capture Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mixer Capture Switch", 0x1a, 0x0, HDA_INPUT),	
+
 	{}
 };
 
-- 
1.6.0.4
