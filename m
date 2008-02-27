From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Using ARRAY_SIZE macro when setting up ASoC audio map?
Date: Wed, 27 Feb 2008 13:49:23 +0200
Message-ID: <20080227134923.aa37870c.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8031F103800
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 12:49:54 +0100 (CET)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m1RBpKGT026970
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 05:51:28 -0600
Received: from kikka3 (esdhcp04136.research.nokia.com [172.21.41.36])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id
	m1RBn4Z9019493
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 13:49:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does an example patch to spitz below make any sense? Yep, noticed when forgot to add array terminator to own code :-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index d56709e..1cffcd3 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -268,8 +268,6 @@ static const char *audio_map[][3] = {
 
 	/* line is connected to input 1 - no bias */
 	{"LINPUT1", NULL, "Line Jack"},
-
-	{NULL, NULL, NULL},
 };
 
 static const char *jack_function[] = {"Headphone", "Mic", "Line", "Headset",
@@ -317,7 +315,7 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	}
 
 	/* Set up spitz specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++) {
+	for (i = 0; i < ARRAY_SIZE(audio_map); i++) {
 		snd_soc_dapm_connect_input(codec, audio_map[i][0],
 			audio_map[i][1], audio_map[i][2]);
 	}
