From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: bebob: fix model-id of unit for Apogee
	Ensemble
Date: Wed, 19 Dec 2018 20:00:42 +0900
Message-ID: <20181219110042.19996-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F334E26782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 12:00:52 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id q1so9663754pfi.5
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 03:00:52 -0800 (PST)
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

This commit fixes hard-coded model-id for an unit of Apogee Ensemble with
a correct value. This unit uses DM1500 ASIC produced ArchWave AG (formerly
known as BridgeCo AG).

I note that this model supports three modes in the number of data channels
in tx/rx streams; 8 ch pairs, 10 ch pairs, 18 ch pairs. The mode is
switched by Vendor-dependent AV/C command, like:

$ cd linux-firewire-utils
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0600000000 (8ch pairs)
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0601000000 (10ch pairs)
$ ./firewire-request /dev/fw1 fcp 0x00ff000003dbeb0602000000 (18ch pairs)

When switching between different mode, the unit disappears from IEEE 1394
bus, then appears on the bus with different combination of stream formats.
In a mode of 18 ch pairs, available sampling rate is up to 96.0 kHz, else
up to 192.0 kHz.

$ ./hinawa-config-rom-printer /dev/fw1
{ 'bus-info': { 'adj': False,
                'bmc': True,
                'chip_ID': 21474898341,
                'cmc': True,
                'cyc_clk_acc': 100,
                'generation': 2,
                'imc': True,
                'isc': True,
                'link_spd': 2,
                'max_ROM': 1,
                'max_rec': 512,
                'name': '1394',
                'node_vendor_ID': 987,
                'pmc': False},
  'root-directory': [ ['HARDWARE_VERSION', 19],
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
                      ['VENDOR', 987],
                      ['DESCRIPTOR', 'Apogee Electronics'],
                      ['MODEL', 126702],
                      ['DESCRIPTOR', 'Ensemble'],
                      ['VERSION', 5297],
                      [ 'UNIT',
                        [ ['SPECIFIER_ID', 41005],
                          ['VERSION', 65537],
                          ['MODEL', 126702],
                          ['DESCRIPTOR', 'Ensemble']]],
                      [ 'DEPENDENT_INFO',
                        [ ['SPECIFIER_ID', 2037],
                          ['VERSION', 1],
                          [(58, 'IMMEDIATE'), 16777159],
                          [(59, 'IMMEDIATE'), 1048576],
                          [(60, 'IMMEDIATE'), 16777159],
                          [(61, 'IMMEDIATE'), 6291456]]]]}

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 672d13488454..d91874275d2c 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -408,7 +408,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* Apogee Electronics, DA/AD/DD-16X (X-FireWire card) */
 	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048, &spec_normal),
 	/* Apogee Electronics, Ensemble */
-	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00001eee, &spec_normal),
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x01eeee, &spec_normal),
 	/* ESI, Quatafire610 */
 	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064, &spec_normal),
 	/* AcousticReality, eARMasterOne */
-- 
2.19.1
