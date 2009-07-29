From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] mpu401.c: Buffer overflow
Date: Wed, 29 Jul 2009 12:12:09 +0200
Message-ID: <4A702079.4080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id B20BA103853
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 12:09:18 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so143410eye.56
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 03:09:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

mpu_synth_info[m].name is a char[30], and the minimum length of the data
written by sprintf is 31 bytes including terminating null.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with Parfait, http://research.sun.com/projects/parfait/

diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 1b2316f..734b8f9 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -1074,7 +1074,7 @@ int attach_mpu401(struct address_info *hw_config, struct module *owner)
 			sprintf(mpu_synth_info[m].name, "%s (MPU401)", hw_config->name);
 		else
 			sprintf(mpu_synth_info[m].name,
-				"MPU-401 %d.%d%c Midi interface #%d",
+				"MPU-401 %d.%d%c MIDI #%d",
 				(int) (devc->version & 0xf0) >> 4,
 				devc->version & 0x0f,
 				revision_char,
