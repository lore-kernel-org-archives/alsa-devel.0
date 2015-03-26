From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Add one more node in the EAPD supporting candidate list
Date: Thu, 26 Mar 2015 17:14:55 +0800
Message-ID: <1427361295-7899-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have a HP machine which use the codec node 0x17 connecting the
internal speaker, and from the node capability, we saw the EAPD,
if we don't set the EAPD on for this node, the internal speaker
can't output any sound.

Cc: <stable@vger.kernel.org>
BugLink: https://bugs.launchpad.net/bugs/1436745
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
picked some content from the alsa-info.txt of this machine:

Codec: Realtek ALC221
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0221
Subsystem Id: 0x103c8105
Revision Id: 0x100103
No Modem Function Group found
...
...
...
Node 0x17 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Speaker Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0f

 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8775389..75880fe 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -396,7 +396,7 @@ static void alc_auto_setup_eapd(struct hda_codec *codec, bool on)
 {
 	/* We currently only handle front, HP */
 	static hda_nid_t pins[] = {
-		0x0f, 0x10, 0x14, 0x15, 0
+		0x0f, 0x10, 0x14, 0x15, 0x17, 0
 	};
 	hda_nid_t *p;
 	for (p = pins; *p; p++)
-- 
1.9.1
