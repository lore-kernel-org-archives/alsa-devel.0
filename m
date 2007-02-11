From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH] V4L/DVB (5061): Bt8xx: add support for
	Ultraview DVB-T Lite
Date: Sun, 11 Feb 2007 17:24:55 -0200
Message-ID: <1171221895.4596.12.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HL3Oq5GfnYEkxaxiDMLE"
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
To: Takashi Iwai <tiwai@suse.de>, alsa devel <alsa-devel@lists.sourceforge.net>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
List-Id: alsa-devel@alsa-project.org


--=-HL3Oq5GfnYEkxaxiDMLE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Takashi,

We are adding support for this newer board. Is this patch ok for you? If
so, I should ask Linus to pull from our tree (since it touches mostly
V4L/DVB tree).

-- 
Cheers,
Mauro

--=-HL3Oq5GfnYEkxaxiDMLE
Content-Disposition: attachment; filename=5061.patch
Content-Type: text/x-patch; name=5061.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit b49e6c2d053ea859af88fc0c8e521034dd5eae22
Author: Michael Krufky <mkrufky@linuxtv.org>
Date:   Sun Jan 7 22:12:22 2007 -0300

    V4L/DVB (5061): Bt8xx: add support for Ultraview DVB-T Lite
    
    Ultraview DVB-T Lite is a clone of DViCO FusionHDTV DVB-T Lite
    
    Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

diff --git a/Documentation/video4linux/CARDLIST.bttv b/Documentation/video4linux/CARDLIST.bttv
index 4efa464..fc2fe9b 100644
--- a/Documentation/video4linux/CARDLIST.bttv
+++ b/Documentation/video4linux/CARDLIST.bttv
@@ -126,7 +126,7 @@
 125 -> MATRIX Vision Sigma-SQ
 126 -> MATRIX Vision Sigma-SLC
 127 -> APAC Viewcomp 878(AMAX)
-128 -> DViCO FusionHDTV DVB-T Lite                         [18ac:db10]
+128 -> DViCO FusionHDTV DVB-T Lite                         [18ac:db10,18ac:db11]
 129 -> V-Gear MyVCD
 130 -> Super TV Tuner
 131 -> Tibet Systems 'Progress DVR' CS16
diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt878.c
index 329a51c..83b090e 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -390,6 +390,7 @@ static struct cards card_list[] __devini
 	{ 0xfc00270f, BTTV_BOARD_TWINHAN_DST,			"ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_BOARD_AVDVBT_771,			"AVermedia AverTV DVB-T 771" },
 	{ 0xdb1018ac, BTTV_BOARD_DVICO_DVBT_LITE,		"DViCO FusionHDTV DVB-T Lite" },
+	{ 0xdb1118ac, BTTV_BOARD_DVICO_DVBT_LITE,		"Ultraview DVB-T Lite" },
 	{ 0xd50018ac, BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE,	"DViCO FusionHDTV 5 Lite" },
 	{ 0x20007063, BTTV_BOARD_PC_HDTV,			"pcHDTV HD-2000 TV" },
 	{ 0x00261822, BTTV_BOARD_TWINHAN_DST,			"DNTV Live! Mini" },
diff --git a/drivers/media/video/bt8xx/bttv-cards.c b/drivers/media/video/bt8xx/bttv-cards.c
index 3b653c9..6addc42 100644
--- a/drivers/media/video/bt8xx/bttv-cards.c
+++ b/drivers/media/video/bt8xx/bttv-cards.c
@@ -307,6 +307,7 @@ static struct CARD {
 	{ 0x07711461, BTTV_BOARD_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
 	{ 0x07611461, BTTV_BOARD_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0xdb1018ac, BTTV_BOARD_DVICO_DVBT_LITE,    "DViCO FusionHDTV DVB-T Lite" },
+	{ 0xdb1118ac, BTTV_BOARD_DVICO_DVBT_LITE,    "Ultraview DVB-T Lite" },
 	{ 0xd50018ac, BTTV_BOARD_DVICO_FUSIONHDTV_5_LITE,    "DViCO FusionHDTV 5 Lite" },
 	{ 0x00261822, BTTV_BOARD_TWINHAN_DST,	"DNTV Live! Mini "},
 
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index c3f3da2..e9b029e 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -804,6 +804,7 @@ static struct {
 	{0x1822, 0x0001}, /* Twinhan VisionPlus DVB-T */
 	{0x18ac, 0xd500}, /* DVICO FusionHDTV 5 Lite */
 	{0x18ac, 0xdb10}, /* DVICO FusionHDTV DVB-T Lite */
+	{0x18ac, 0xdb11}, /* Ultraview DVB-T Lite */
 	{0x270f, 0xfc00}, /* Chaintech Digitop DST-1000 DVB-S */
 	{0x7063, 0x2000}, /* pcHDTV HD-2000 TV */
 };

--=-HL3Oq5GfnYEkxaxiDMLE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-HL3Oq5GfnYEkxaxiDMLE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-HL3Oq5GfnYEkxaxiDMLE--
