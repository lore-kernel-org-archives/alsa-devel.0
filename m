From: Frank Murphy <murphyf+alsa@f-m.fm>
Subject: Re: BUG: Balance inverted on ppc with PowerMac DACA
Date: Mon, 1 Sep 2003 13:05:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309011305.24208.murphyf+alsa@f-m.fm>
References: <200308291655.05073.murphyf+alsa@f-m.fm>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yfyU/ke/TSkqYww"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308291655.05073.murphyf+alsa@f-m.fm>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_yfyU/ke/TSkqYww
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 29 August 2003 5:13, Frank Murphy wrote:
> On Friday 29 August 2003 4:55, Frank Murphy wrote:
> > I'm on Debain sid with default kernel-image-2.4.21-powerpc and alsa-base
> > (0.9.6-2), alsa-modules-2 (0.9.6-1), alsa-source (0.9.6-2), and
> > alsa-utils (0.9.6-1).
>
> I forgot to say that I'm on an original Apple iBook and the module that
> gets loaded is snd-powermac. In alsamixer, it says "PowerMac DACA".
>
> Frank

So, I've located and fixed the problem. Left channel should have been 0, not 
1. Patch attached. Please apply.

Frank

--Boundary-00=_yfyU/ke/TSkqYww
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="daca.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="daca.patch"

--- daca.c.dist	2003-09-01 13:01:57.000000000 +0200
+++ daca.c	2003-09-01 12:34:32.000000000 +0200
@@ -74,14 +74,14 @@
 	if (! mix->i2c.client)
 		return -ENODEV;
   
-	if (mix->right_vol > DACA_VOL_MAX)
+	if (mix->left_vol > DACA_VOL_MAX)
 		data[0] = DACA_VOL_MAX;
 	else
-		data[0] = mix->right_vol;
-	if (mix->left_vol > DACA_VOL_MAX)
+		data[0] = mix->left_vol;
+	if (mix->right_vol > DACA_VOL_MAX)
 		data[1] = DACA_VOL_MAX;
 	else
-		data[1] = mix->left_vol;
+		data[1] = mix->right_vol;
 	data[1] |= mix->deemphasis ? 0x40 : 0;
 	if (snd_pmac_keywest_write(&mix->i2c, DACA_REG_AVOL, 2, data) < 0) {
 		snd_printk("failed to set volume \n");  

--Boundary-00=_yfyU/ke/TSkqYww--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
