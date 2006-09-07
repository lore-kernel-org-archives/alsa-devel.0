From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] WM9705 AC97 patch build error
Date: Thu, 07 Sep 2006 16:58:32 +0100
Message-ID: <1157644712.20713.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9VRlbsa00fXtnKFTk2oa"
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
Cc: Rodolfo Giometti <giometti@linux.it>
List-Id: alsa-devel@alsa-project.org


--=-9VRlbsa00fXtnKFTk2oa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes a build error (introduced by me) in ac97_patch.c wrt
WM9705 touchscreen.

Changes:-

 o Removed spurious '3D' from character after |= operation (0x3D is
ASCII for '=')
 

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>



--=-9VRlbsa00fXtnKFTk2oa
Content-Disposition: attachment; filename=wm9705-touch.patch
Content-Type: text/x-patch; name=wm9705-touch.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 232a221b7103 pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c     Thu Aug 31 17:03:43 2006 +0200
+++ b/pci/ac97/ac97_patch.c     Thu Sep 07 16:46:20 2006 +0100
@@ -481,7 +481,7 @@ int patch_wolfson05(struct snd_ac97 * ac
        ac97->build_ops = &patch_wolfson_wm9705_ops;
 #ifdef CONFIG_TOUCHSCREEN_WM9705
        /* WM9705 touchscreen uses AUX and VIDEO for touch */
-       ac97->flags |=3D AC97_HAS_NO_VIDEO | AC97_HAS_NO_AUX;
+       ac97->flags |= AC97_HAS_NO_VIDEO | AC97_HAS_NO_AUX;
 #endif
        return 0;
 }

--=-9VRlbsa00fXtnKFTk2oa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-9VRlbsa00fXtnKFTk2oa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-9VRlbsa00fXtnKFTk2oa--
