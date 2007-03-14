From: Nicolas Boichat <nicolas@boichat.ch>
Subject: Macbook Pro pins in patch_sigmatel
Date: Thu, 15 Mar 2007 02:54:24 +0800
Message-ID: <45F844E0.7060707@boichat.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I just came across this git commit:
http://git.kernel.org/?p=linux/kernel/git/perex/alsa.git;a=commitdiff;h=3fc24d850708b8dfd3472b25eac0c32dd7708925

I also have a Macbook Pro, but my codec->subsystem_id is different
(0x106b0200), and I need to use different pins to get the mic to work:

    0x0321E230, 0x03A1E020, 0x9017E110, 0x01014010,
    0x01a19021, 0x0381E021, 0x1345E240, 0x13C5E22E,
    0x02a19320, 0x400000FB,

Which Macbook Pro are you talking about? I have a first generation
Macbook Pro (bought in April 2006, Core Duo (not Core 2 Duo)), so I
assume you tested your patches on a 2nd generation Macbook Pro.

I attached a patch to fix this problem against the latest linus' git. I
also added a line which prints the subsystem_id in dmesg, so I can ask
users on mactel-linux for their subsystem_ids (Macbook non-Pro audio
probably won't work fine currently).

(please CC me I'm not subscribed to alsa-devel list)

Best regards,

Nicolas Boichat



Fix audio on Macbook Pro 1st generation.

Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>


---

 Documentation/sound/alsa/ALSA-Configuration.txt |    3 ++-
 sound/pci/hda/patch_sigmatel.c                  |   23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index db398a6..0c2ab4e 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -906,7 +906,8 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 	  5stack	D945 5stack + SPDIF
 	  macmini	Intel Mac Mini
 	  macbook	Intel Mac Book
-	  macbook-pro	Intel Mac Book Pro
+	  macbook-pro-v1 Intel Mac Book Pro 1st generation
+	  macbook-pro-v2 Intel Mac Book Pro 2nd generation
 
 	STAC9202/9250/9251
 	  ref		Reference board, base config
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 4c7b039..077d718 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -60,7 +60,8 @@ enum {
 	STAC_D945GTP5,
 	STAC_MACMINI,
 	STAC_MACBOOK,
-	STAC_MACBOOK_PRO,
+	STAC_MACBOOK_PRO_V1,
+	STAC_MACBOOK_PRO_V2,
 	STAC_922X_MODELS
 };
 
@@ -529,7 +530,13 @@ static unsigned int macbook_pin_configs[10] = {
 	0x400000fc, 0x400000fb,
 };
 
-static unsigned int macbook_pro_pin_configs[10] = {
+static unsigned int macbook_pro_v1_pin_configs[10] = {
+	0x0321E230, 0x03A1E020, 0x9017E110, 0x01014010,
+	0x01a19021, 0x0381E021, 0x1345E240, 0x13C5E22E,
+	0x02a19320, 0x400000FB,
+};
+
+static unsigned int macbook_pro_v2_pin_configs[10] = {
 	0x0221401f, 0x90a70120, 0x01813024, 0x01014010,
 	0x400000fd, 0x01016011, 0x1345e240, 0x13c5e22e,
 	0x400000fc, 0x400000fb,
@@ -541,7 +548,8 @@ static unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
 	[STAC_D945GTP5] = d945gtp5_pin_configs,
 	[STAC_MACMINI] = d945gtp5_pin_configs,
 	[STAC_MACBOOK] = macbook_pin_configs,
-	[STAC_MACBOOK_PRO] = macbook_pro_pin_configs,
+	[STAC_MACBOOK_PRO_V1] = macbook_pro_v1_pin_configs,
+	[STAC_MACBOOK_PRO_V2] = macbook_pro_v2_pin_configs,
 };
 
 static const char *stac922x_models[STAC_922X_MODELS] = {
@@ -550,7 +558,8 @@ static const char *stac922x_models[STAC_922X_MODELS] = {
 	[STAC_D945GTP3]	= "3stack",
 	[STAC_MACMINI]	= "macmini",
 	[STAC_MACBOOK]	= "macbook",
-	[STAC_MACBOOK_PRO]	= "macbook-pro",
+	[STAC_MACBOOK_PRO_V1]	= "macbook-pro-v1",
+	[STAC_MACBOOK_PRO_V2]	= "macbook-pro-v2",
 };
 
 static struct snd_pci_quirk stac922x_cfg_tbl[] = {
@@ -1889,9 +1898,13 @@ static int patch_stac922x(struct hda_codec *codec)
 		/* Intel Macs have all same PCI SSID, so we need to check
 		 * codec SSID to distinguish the exact models
 		 */
+		printk(KERN_INFO "hda_codec: STAC922x, Apple subsys_id=%x\n", codec->subsystem_id);
 		switch (codec->subsystem_id) {
+		case 0x106b0200: /* MacBook Pro first generation */
+			spec->board_config = STAC_MACBOOK_PRO_V1;
+			break;
 		case 0x106b1e00:
-			spec->board_config = STAC_MACBOOK_PRO;
+			spec->board_config = STAC_MACBOOK_PRO_V2;
 			break;
 		}
 	}



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
