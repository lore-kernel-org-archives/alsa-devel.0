From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC very minor coding style fix for
	snd_soc_new_pcms()
Date: Wed, 31 Jan 2007 17:22:44 +0000
Message-ID: <1170264164.16760.91.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-9Qv24CQ7Xsh/5ZpxUCVX"
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
List-Id: alsa-devel@alsa-project.org


--=-9Qv24CQ7Xsh/5ZpxUCVX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This very minor patch fixes the snd_soc_new_pcms() function to comply
with the kernel coding style.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>


--=-9Qv24CQ7Xsh/5ZpxUCVX
Content-Disposition: attachment; filename=asoc-new-pcm-style.patch
Content-Type: text/x-patch; name=asoc-new-pcm-style.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 2a5adb550155 soc/soc-core.c
--- a/soc/soc-core.c	Wed Jan 31 14:34:38 2007 +0100
+++ b/soc/soc-core.c	Wed Jan 31 17:11:46 2007 +0000
@@ -1522,7 +1522,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_rate);
  *
  * Returns 0 for success, else error.
  */
-int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char * xid)
+int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 {
 	struct snd_soc_codec *codec = socdev->codec;
 	struct snd_soc_machine *machine = socdev->machine;

--=-9Qv24CQ7Xsh/5ZpxUCVX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-9Qv24CQ7Xsh/5ZpxUCVX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-9Qv24CQ7Xsh/5ZpxUCVX--
