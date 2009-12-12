From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Overwrite pin config on intel DG45ID board.
Date: Sat, 12 Dec 2009 11:16:41 +0200
Message-ID: <1260609401-4938-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 6000F2462A
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 10:16:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

The pin config provided by BIOS have some problems:
0x0221401f: [Jack] HP Out at Ext Front  <-- other association and sequence
0x02a19020: [Jack] Mic at Ext Front     <-- other association
0x01113014: [Jack] Speaker at Ext Rear  <-- line out (not speaker)
0x01114010: [Jack] Speaker at Ext Rear  <-- line out
0x01a19030: [Jack] Mic at Ext Rear      <-- other association
0x01111012: [Jack] Speaker at Ext Rear  <-- line out
0x01116011: [Jack] Speaker at Ext Rear  <-- line out
0x40f000f0: [N/A] Other at Ext N/A
0x40f000f0: [N/A] Other at Ext N/A
0x40f000f0: [N/A] Other at Ext N/A
0x40f000f0: [N/A] Other at Ext N/A
0x40f000f0: [N/A] Other at Ext N/A
0x01451140: [Jack] SPDIF Out at Ext Rear
0x40f000f0: [N/A] Other at Ext N/A

just overwrite it.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/pci/hda/patch_sigmatel.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6b0bc04..395c174 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1538,6 +1538,13 @@ static unsigned int alienware_m17x_pin_configs[13] = {
 	0x904601b0,
 };
 
+static unsigned int intel_dg45id_pin_configs[14] = {
+	0x02214230, 0x02A19240, 0x01013214, 0x01014210,
+	0x01A19250, 0x01011212, 0x01016211, 0x40f000f0,
+	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x014510A0,
+	0x074510B0, 0x40f000f0
+};
+
 static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
 	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
 	[STAC_DELL_M6_AMIC]	= dell_m6_pin_configs,
@@ -1545,6 +1552,7 @@ static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
 	[STAC_DELL_M6_BOTH]	= dell_m6_pin_configs,
 	[STAC_DELL_EQ]	= dell_m6_pin_configs,
 	[STAC_ALIENWARE_M17X]	= alienware_m17x_pin_configs,
+	[STAC_92HD73XX_INTEL]	= intel_dg45id_pin_configs,
 };
 
 static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
-- 
1.6.3.3
