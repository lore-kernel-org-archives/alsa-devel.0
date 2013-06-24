From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Use auto_mute_via_amp=1 for
	VT1708
Date: Mon, 24 Jun 2013 16:32:57 +0200
Message-ID: <1372084377-14431-4-git-send-email-tiwai@suse.de>
References: <1372084377-14431-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ACFF2651BC
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:14 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4845A5211
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:32:11 +0200 (CEST)
In-Reply-To: <1372084377-14431-1-git-send-email-tiwai@suse.de>
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

We've got bug report wrt many machines with VT1708 (e.g. IBM POS
machines) showing the broken auto-mute behavior.  It turned out that
the problem is that the pin control values of the speaker and line-out
pins are completely ignored.  As a workaround, let's use the newly
introduced feature of the generic parser, to control the mute via amp
on pins.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index dcebf3c..e2481ba 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -741,6 +741,8 @@ static int patch_vt1708(struct hda_codec *codec)
 	/* don't support the input jack switching due to lack of unsol event */
 	/* (it may work with polling, though, but it needs testing) */
 	spec->gen.suppress_auto_mic = 1;
+	/* Some machines show the broken speaker mute */
+	spec->gen.auto_mute_via_amp = 1;
 
 	/* Add HP and CD pin config connect bit re-config action */
 	vt1708_set_pinconfig_connect(codec, VT1708_HP_PIN_NID);
-- 
1.8.3.1
