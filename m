From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: minor send routing cleanup
Date: Tue, 16 Nov 2004 17:55:45 -0500
Message-ID: <1100645745.17573.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Use snd_emu10k1_compose_audigy_fxrt* macro where appropriate.  Also add
a few comments to explain send routing structure.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

diff -Nru alsa-multi/alsa-kernel/include/emu10k1.h alsa-dev/alsa-kernel/include/emu10k1.h
--- alsa-multi/alsa-kernel/include/emu10k1.h	2004-11-16 17:44:27.000000000 -0500
+++ alsa-dev/alsa-kernel/include/emu10k1.h	2004-11-16 17:31:39.000000000 -0500
@@ -833,6 +833,7 @@
 };
 
 typedef struct {
+	/* mono, left, right x 8 sends (4 on emu10k1) */
 	unsigned char send_routing[3][8];
 	unsigned char send_volume[3][8];
 	unsigned short attn[3];
diff -Nru alsa-multi/alsa-kernel/pci/emu10k1/emupcm.c alsa-dev/alsa-kernel/pci/emu10k1/emupcm.c
--- alsa-multi/alsa-kernel/pci/emu10k1/emupcm.c	2004-11-16 17:44:25.000000000 -0500
+++ alsa-dev/alsa-kernel/pci/emu10k1/emupcm.c	2004-11-16 17:31:30.000000000 -0500
@@ -336,6 +336,7 @@
 		send_routing[3] = 3;
 		memset(send_amount, 0, sizeof(send_amount));
 	} else {
+		/* mono, left, right (master voice = left) */
 		tmp = stereo ? (master ? 1 : 2) : 0;
 		memcpy(send_routing, &mix->send_routing[tmp][0], 8);
 		memcpy(send_amount, &mix->send_volume[tmp][0], 8);
@@ -363,15 +364,9 @@
 	// setup routing
 	if (emu->audigy) {
 		snd_emu10k1_ptr_write(emu, A_FXRT1, voice,
-				      ((unsigned int)send_routing[3] << 24) |
-				      ((unsigned int)send_routing[2] << 16) |
-				      ((unsigned int)send_routing[1] << 8) |
-				      (unsigned int)send_routing[0]);
+				      snd_emu10k1_compose_audigy_fxrt1(send_routing));
 		snd_emu10k1_ptr_write(emu, A_FXRT2, voice,
-				      ((unsigned int)send_routing[7] << 24) |
-				      ((unsigned int)send_routing[6] << 16) |
-				      ((unsigned int)send_routing[5] << 8) |
-				      (unsigned int)send_routing[4]);
+				      snd_emu10k1_compose_audigy_fxrt2(send_routing));
 		snd_emu10k1_ptr_write(emu, A_SENDAMOUNTS, voice,
 				      ((unsigned int)send_amount[4] << 24) |
 				      ((unsigned int)send_amount[5] << 16) |




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
