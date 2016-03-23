From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Apply fix for white noise on
	Asus N550JV, too
Date: Wed, 23 Mar 2016 14:52:04 +0100
Message-ID: <1458741124-19511-3-git-send-email-tiwai@suse.de>
References: <1458741124-19511-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A032673C5
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 14:52:06 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1253FADB7
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 13:52:05 +0000 (UTC)
In-Reply-To: <1458741124-19511-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Bobi Mihalca <bobbymihalca@touchtech.ro>

Apply the new fixup that is used for ASUS N750JV to another similar
model, N500JV, too, for reducing the headphone noise.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=115181
Signed-off-by: Bobi Mihalca <bobbymihalca@touchtech.ro>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6bac82814b3..73978c79981f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6675,7 +6675,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
-	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A),
+	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x13df, "Asus N550JX", ALC662_FIXUP_BASS_1A),
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_MODE4_CHMAP),
-- 
2.7.4
