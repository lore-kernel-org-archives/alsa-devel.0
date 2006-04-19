From: Bastiaan Jacques <bastiaan@dahhosting.com>
Subject: [PATCH ALSA-1.0.11] via82xx: tweak VT8251 workaround
Date: Thu, 20 Apr 2006 01:53:39 +0200
Message-ID: <200604200153.39834.bastiaan@dahhosting.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Move the workaround for the VT8251 up a bit, and check for STAT_EOL
rather than STAT_ACTIVE. This resolves issues some people were having
with certain ALSA clients (and allows the STAT_ACTIVE check to do what
it was intended to do).

This change was suggested by Andrew Daviel.

Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
---

--- pci/via82xx.c.orig	2006-04-20 01:39:10.000000000 +0200
+++ pci/via82xx.c	2006-04-20 01:41:59.000000000 +0200
@@ -863,16 +863,14 @@ static snd_pcm_uframes_t snd_via8233_pcm
 	if (!status)
 		status = inb(VIADEV_REG(viadev, OFFSET_STATUS));
 
+	/* An apparent bug in the 8251 is worked around by sending a 
+	 * REG_CTRL_START. */
+	if (chip->revision == VIA_REV_8251 && (status & VIA_REG_STAT_EOL))
+		snd_via82xx_pcm_trigger(substream, SNDRV_PCM_TRIGGER_START);
+
 	if (!(status & VIA_REG_STAT_ACTIVE)) {
-		/* An apparent bug in the 8251 is worked around by sending
-		 * a REG_CTRL_START. */
-		if (chip->revision == VIA_REV_8251)
-			snd_via82xx_pcm_trigger(substream,
-						SNDRV_PCM_TRIGGER_START);
-		else {
-			res = 0;
-			goto unlock;
-		}
+		res = 0;
+		goto unlock;
 	}
 	if (count & 0xffffff) {
 		idx = count >> 24;


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
