From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Small patch for alsa-lib
Date: Tue, 20 Jan 2004 13:32:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400D1FDC.9040804@pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040601090608090503030503"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040601090608090503030503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Welcome

I observe that while using xmms with ALSA output plugin
and alsa-20040120 compiled lib we get shared memory usage growing.
Any opening of new sound source (sound file etc.) adds a new shm segment 
while old segments stay in memory until xmms exits.
Sometimes they stay even after application closing and must be removed 
manually.
I am sending a small patch which should remove this behaviour.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Technical University of Gdansk, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

--------------040601090608090503030503
Content-Type: text/plain;
 name="alsa-20040120.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-20040120.patch"

--- alsa-20040120/alsa-lib/src/pcm/pcm_mmap_old.c	2004-01-20 11:03:28.000000000 +0100
+++ alsa-20040120/alsa-lib/src/pcm/pcm_mmap.c	2004-01-20 13:04:03.000000000 +0100
@@ -462,11 +462,16 @@
 			if (i->u.shm.area) {
 				snd_shm_area_destroy(i->u.shm.area);
 				i->u.shm.area = NULL;
-			} else {
-				err = shmdt(i->addr);
-				if (err < 0) {
-					SYSERR("shmdt failed");
-					return -errno;
+				if (pcm->access == SND_PCM_ACCESS_MMAP_INTERLEAVED ||
+				    pcm->access == SND_PCM_ACCESS_RW_INTERLEAVED) {
+					unsigned int c1;
+					for (c1 = c + 1; c1 < pcm->channels; c1++) {
+						snd_pcm_channel_info_t *i1 = &pcm->mmap_channels[c1];
+						if (i1->u.shm.area) {
+							snd_shm_area_destroy(i1->u.shm.area);
+							i1->u.shm.area = NULL;
+						}
+					}
 				}
 			}
 			break;

--------------040601090608090503030503--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
