From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: oxfw: add support for APOGEE duet
	FireWire
Date: Tue, 13 Nov 2018 12:01:30 +0900
Message-ID: <20181113030130.22073-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id ADB9226751A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 04:01:38 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id t13so2287949ply.13
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 19:01:38 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds support for APOGEE duet FireWire, launched 2007, already
discontinued. This model uses Oxford Semiconductor FW971 as its
communication engine. Below is information on Configuration ROM of this
unit. The unit supports some AV/C commands defined by Audio subunit
specification and vendor dependent commands.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': False,
                'chip_ID': 42949742248,
                'cmc': False,
                'cyc_clk_acc': 255,
                'generation': 0,
                'imc': False,
                'isc': True,
                'link_spd': 3,
                'max_ROM': 0,
                'max_rec': 64,
                'name': '1394',
                'node_vendor_ID': 987,
                'pmc': False},
  'root-directory': [ ['VENDOR', 987],
                      ['DESCRIPTOR', 'Apogee Electronics'],
                      ['MODEL', 122333],
                      ['DESCRIPTOR', 'Duet'],
                      [ 'NODE_CAPABILITIES',
                        { 'addressing': {'64': True, 'fix': True, 'prv': False},
                          'misc': {'int': False, 'ms': False, 'spt': True},
                          'state': { 'atn': False,
                                     'ded': False,
                                     'drq': True,
                                     'elo': False,
                                     'init': False,
                                     'lst': True,
                                     'off': False},
                          'testing': {'bas': False, 'ext': False}}],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 41005],
                          ['VERSION', 65537],
                          ['MODEL', 122333],
                          ['DESCRIPTOR', 'Duet']]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig     | 1 +
 sound/firewire/oxfw/oxfw.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 8a146b039276..44cedb65bb88 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -41,6 +41,7 @@ config SND_OXFW
 	   * Mackie(Loud) U.420/U.420d
 	   * TASCAM FireOne
 	   * Stanton Controllers & Systems 1 Deck/Mixer
+	   * APOGEE duet FireWire
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-oxfw.
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index afb78d90384b..3d27f3378d5d 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -20,6 +20,7 @@
 #define VENDOR_LACIE		0x00d04b
 #define VENDOR_TASCAM		0x00022e
 #define OUI_STANTON		0x001260
+#define OUI_APOGEE		0x0003db
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -397,6 +398,13 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.vendor_id	= OUI_STANTON,
 		.model_id	= 0x002000,
 	},
+	// APOGEE, duet FireWire
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_APOGEE,
+		.model_id	= 0x01dddd,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.19.1
