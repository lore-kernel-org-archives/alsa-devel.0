From: hwang4 <hui.wang@canonical.com>
Subject: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Tue, 09 Jun 2015 17:38:33 +0800
Message-ID: <5576B419.5010505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A7F7026516E
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 11:38:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to enable the subwoofer speaker on a HP laptop, on this
machine, there are two speakers and one headphone, but the BIOS verb
only enabled one speaker(nid 0xd) and one headphone(nid 0xb), I need
to use quirk in the kernel driver to configure the second speaker
(subwoofer speaker, nid 0x10). Under current alsa driver, the
headphone will be assigned a dac (nid 0x13) and the 2 speakers will
be assigned a dac (nid 0x14), this assignment is not good since 2
speakers share the same dac, this means 2 speakers can't work
at the same time to support 4.0/2.1 channels.

On another Dell machine with realtek codec, there are also 2 speakers,
1 headphone and 2 dacs, on this machine, 1 speaker and 1 headphone are 
assigned
1 dac, and the other speaker is assigned another dac, so there is no
problem for this machine to support 4.0/2.1 channels.

Through debugging, I found on Dell machine, the speaker nid only has
one connection to dac (hardwired), so when driver assign dac to it, the
map_single() can successfully assign the each dac to the 2 speakers 
respectively.
But on that HP machine, the speaker has multiple connections for dac, the
map_single() can't work for this machine.


The alsa-info.txt for that HP machine is at 
http://pastebin.ubuntu.com/11667947/
The alsa-info.txt for that Dell machine is at 
http://pastebin.ubuntu.com/11667982/

To fix this problem, I can use the quirk in the driver to make the 
speaker have
only one connection for dac or do some change in the hda_generic.c like 
below, in
your opinion, which one is better or probably you have a different idea 
to fix this problem?

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ac0db16..8194ff1 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1363,6 +1363,7 @@ static int try_assign_dacs(struct hda_codec 
*codec, int num_outs,
                                 dac = try_dac(codec, 
get_primary_out(codec, i), pin);
                         if (!dac)
                                 dac = try_dac(codec, dacs[0], pin);
                         if (!dac)
                                 dac = try_dac(codec, 
get_primary_out(codec, i), pin);
                         if (dac) {
@@ -1762,6 +1763,12 @@ static int fill_and_eval_dacs(struct hda_codec 
*codec,
                 if (err < 0)
                         return err;
                 badness += err;
+               /* if there are 2 speakers and both of them are assigned 
to the same dac,
+                  we need to increase the badness for this situation, 
because in this situation
+                  the 2 speakers can't work together to support 4.0/2.1 
channels */
+               if (cfg->speaker_outs == 2 && err < 
spec->extra_out_badness->no_dac &&
+                   spec->multiout.extra_out_nid[1] == 0)
+                       badness += spec->extra_out_badness->no_dac;
         }
         if (!spec->no_multi_io &&
             cfg->line_outs == 1 && cfg->line_out_type != 
AUTO_PIN_SPEAKER_OUT) {
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index bdcda6a..717259c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -2764,6 +2764,8 @@ static const struct snd_pci_quirk 
stac92hd83xxx_fixup_tbl[] = {
                           "HP bNB13", STAC_HP_BNB13_EQ),
         SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x190e,
                           "HP ENVY TS", STAC_HP_ENVY_TS_BASS),
+       SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1967,
+                         "HP ENVY TS", STAC_HP_ENVY_TS_BASS),
         SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1940,
                           "HP bNB13", STAC_HP_BNB13_EQ),
         SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1941,
