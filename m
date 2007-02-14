From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] WM9712 PCM volume
Date: Wed, 14 Feb 2007 13:36:24 +0000
Message-ID: <1171460184.13765.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5IMCs0yPai57+gS6WBQf"
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
Cc: Joe Sauer <jsauer@vernier.com>
List-Id: alsa-devel@alsa-project.org


--=-5IMCs0yPai57+gS6WBQf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch suggested by Joe Sauer adds PCM playback volume kcontrol for
the WM9712.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

--=-5IMCs0yPai57+gS6WBQf
Content-Disposition: attachment; filename=asoc-wm9712-pcm-vol.patch
Content-Type: text/x-patch; name=asoc-wm9712-pcm-vol.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r ee0908962557 soc/codecs/wm9712.c
--- a/soc/codecs/wm9712.c	Wed Feb 14 13:26:17 2007 +0100
+++ b/soc/codecs/wm9712.c	Wed Feb 14 13:25:47 2007 +0000
@@ -96,6 +96,7 @@ SOC_SINGLE("Speaker Playback Switch", AC
 SOC_SINGLE("Speaker Playback Switch", AC97_MASTER, 15, 1, 1),
 SOC_DOUBLE("Headphone Playback Volume", AC97_HEADPHONE, 8, 0, 31, 1),
 SOC_SINGLE("Headphone Playback Switch", AC97_HEADPHONE,15, 1, 1),
+SOC_DOUBLE("PCM Playback Volume", AC97_PCM, 8, 0, 31, 1),
 
 SOC_SINGLE("Speaker Playback ZC Switch", AC97_MASTER, 7, 1, 0),
 SOC_SINGLE("Speaker Playback Invert Switch", AC97_MASTER, 6, 1, 0),

--=-5IMCs0yPai57+gS6WBQf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-5IMCs0yPai57+gS6WBQf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-5IMCs0yPai57+gS6WBQf--
