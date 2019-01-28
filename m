From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: add support for Solid State Logic
	Duende Classic/Mini
Date: Mon, 28 Jan 2019 20:40:58 +0900
Message-ID: <20190128114058.31805-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D0FBD267454
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 12:41:10 +0100 (CET)
Received: by mail-pg1-f194.google.com with SMTP id g189so7107022pgc.5
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 03:41:10 -0800 (PST)
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

Duende Classic was produced by Solid State Logic in 2006, as a
first model of Duende DSP series. The following model, Duende Mini
was produced in 2008. They are designed to receive isochronous
packets for PCM frames via IEEE 1394 bus, perform signal processing by
downloaded program, then transfer isochronous packets for converted
PCM frames.

These two models includes the same embedded board, consists of several
ICs below:
 - Texus Instruments Inc, TSB41AB3 for physical layer of IEEE 1394 bus
 - WaveFront semiconductor, DICE II STD ASIC for link/protocol layer
 - Altera MAX 3000A CPLD for programs
 - Analog devices, SHARC ADSP-21363 for signal processing (4 chips)

This commit adds support for the two models to ALSA dice driver. Like
support for the other devices, packet streaming is just available.
Userspace applications should be developed if full features became
available; e.g. program uploader and parameter controller.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': False,
                'chip_ID': 349771402425,
                'cmc': True,
                'cyc_clk_acc': 255,
                'generation': 1,
                'imc': True,
                'isc': True,
                'link_spd': 2,
                'max_ROM': 1,
                'max_rec': 512,
                'name': '1394',
                'node_vendor_ID': 20674,
                'pmc': False},
  'root-directory': [ ['VENDOR', 20674],
                      ['DESCRIPTOR', 'Solid State Logic'],
                      ['MODEL', 112],
                      ['DESCRIPTOR', 'Duende board'],
                      [ 'NODE_CAPABILITIES',
                        { 'addressing': {'64': True, 'fix': True, 'prv': True},
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
                        [ ['SPECIFIER_ID', 20674],
                          ['VERSION', 1],
                          ['MODEL', 112],
                          ['DESCRIPTOR', 'Duende board']]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index ed50b222d36e..eee184b05d93 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -18,6 +18,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_ALESIS		0x000595
 #define OUI_MAUDIO		0x000d6c
 #define OUI_MYTEK		0x001ee8
+#define OUI_SSL			0x0050c2	// Actually ID reserved by IEEE.
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
@@ -196,7 +197,7 @@ static int dice_probe(struct fw_unit *unit,
 	struct snd_dice *dice;
 	int err;
 
-	if (!entry->driver_data) {
+	if (!entry->driver_data && entry->vendor_id != OUI_SSL) {
 		err = check_dice_category(unit);
 		if (err < 0)
 			return -ENODEV;
@@ -361,6 +362,15 @@ static const struct ieee1394_device_id dice_id_table[] = {
 		.model_id	= 0x000002,
 		.driver_data = (kernel_ulong_t)snd_dice_detect_mytek_formats,
 	},
+	// Solid State Logic, Duende Classic and Mini.
+	// NOTE: each field of GUID in config ROM is not compliant to standard
+	// DICE scheme.
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_SSL,
+		.model_id	= 0x000070,
+	},
 	{
 		.match_flags = IEEE1394_MATCH_VERSION,
 		.version     = DICE_INTERFACE,
-- 
2.19.1
