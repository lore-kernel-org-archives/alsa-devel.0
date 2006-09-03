From: syrjala@sci.fi
Subject: [PATCH] ac97: Fix AD1819 volume range (try 2)
Date: Sun, 03 Sep 2006 05:48:25 +0300
Message-ID: <20060903024824.957791934@proteus.korsu.shacknet.nu>
Content-Type: multipart/mixed; boundary="===============1721673645=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Ville Syrjala <syrjala@sci.fi>
List-Id: alsa-devel@alsa-project.org

--===============1721673645==
Content-Disposition: inline; filename=ac97_fix_ad1819_volume_range.patch

AD1819 volume registers can hold extra bits which do not affect the
actual volume. Add a res_table to the codec patch to fix the problem.
PCM, line and mic volume were tested.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 sound/pci/ac97/ac97_patch.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.18-rc5-vs/sound/pci/ac97/ac97_patch.c
===================================================================
--- linux-2.6.18-rc5-vs.orig/sound/pci/ac97/ac97_patch.c
+++ linux-2.6.18-rc5-vs/sound/pci/ac97/ac97_patch.c
@@ -1380,6 +1380,17 @@ static void ad1888_resume(struct snd_ac9
 
 #endif
 
+static const struct snd_ac97_res_table ad1819_restbl[] = {
+	{ AC97_PHONE, 0x9f1f },
+	{ AC97_MIC, 0x9f1f },
+	{ AC97_LINE, 0x9f1f },
+	{ AC97_CD, 0x9f1f },
+	{ AC97_VIDEO, 0x9f1f },
+	{ AC97_AUX, 0x9f1f },
+	{ AC97_PCM, 0x9f1f },
+	{ } /* terminator */
+};
+
 int patch_ad1819(struct snd_ac97 * ac97)
 {
 	unsigned short scfg;
@@ -1387,6 +1398,7 @@ int patch_ad1819(struct snd_ac97 * ac97)
 	// patch for Analog Devices
 	scfg = snd_ac97_read(ac97, AC97_AD_SERIAL_CFG);
 	snd_ac97_write_cache(ac97, AC97_AD_SERIAL_CFG, scfg | 0x7000); /* select all codecs */
+	ac97->res_table = ad1819_restbl;
 	return 0;
 }
 

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1721673645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1721673645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1721673645==--
