From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: [PATCH] hda_intel prefer 24bit instead of 20bit
Date: Sat, 16 Sep 2006 23:03:04 +0200
Message-ID: <450C6688.10507@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070708020508050008030800"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88CEB16A
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Sep 2006 23:03:08 +0200 (MEST)
Received: from grazy (rob92-2-82-66-38-107.fbx.proxad.net [82.66.38.107])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 1B835255E7
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Sep 2006 23:03:08 +0200 (CEST)
Received: from grazy ([127.0.0.1]) by grazy with esmtp (Exim 4.63)
	(envelope-from <nicolas.graziano@wanadoo.fr>) id 1GOhJZ-0002Q1-BA
	for alsa-devel@alsa-project.org; Sat, 16 Sep 2006 23:03:05 +0200
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070708020508050008030800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If I understand the hda_intel code, for format > 20bit it only advertise
the SNDRV_PCM_FMTBIT_S32_LE format and play it at 32 bit, 20 bit or 24 bit.

But if the 20bit and 24bit are available, actually it prefer the 20bit
format. This path is to prefer the 24bit format instead of 20bit.

Signed-off-by: Nicolas Graziano <nicolas.graziano@wanadoo.fr>

Nicolas

--------------070708020508050008030800
Content-Type: text/x-patch;
 name="prefer24bitto20bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prefer24bitto20bit.patch"

diff -r b641fc7ea072 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Tue Sep 12 15:35:35 2006 +0200
+++ b/pci/hda/hda_codec.c	Sat Sep 16 18:11:58 2006 +0200
@@ -1503,10 +1503,10 @@ int snd_hda_query_supported_pcm(struct h
 				formats |= SNDRV_PCM_FMTBIT_S32_LE;
 				if (val & AC_SUPPCM_BITS_32)
 					bps = 32;
+				else if (val & AC_SUPPCM_BITS_24)
+					bps = 24;
 				else if (val & AC_SUPPCM_BITS_20)
 					bps = 20;
-				else if (val & AC_SUPPCM_BITS_24)
-					bps = 24;
 			}
 		}
 		else if (streams == AC_SUPFMT_FLOAT32) { /* should be exclusive */

--------------070708020508050008030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------070708020508050008030800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070708020508050008030800--
