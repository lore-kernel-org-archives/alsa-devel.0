From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 3/5] ALSA: hda - get subvendor from codec
	rather than pci_dev
Date: Mon, 26 May 2014 16:22:42 +0800
Message-ID: <1401092564-14293-3-git-send-email-hui.wang@canonical.com>
References: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DF1F726170F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 10:23:20 +0200 (CEST)
Received: by mail-pa0-f45.google.com with SMTP id ey11so7284363pad.32
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 01:23:19 -0700 (PDT)
In-Reply-To: <1401092564-14293-1-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

It is safer for non-pci situation.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index a142753..b684c6e 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -860,7 +860,7 @@ void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 		return;
 
 	for (pq = pin_quirk; pq->subvendor; pq++) {
-		if (codec->bus->pci->subsystem_vendor != pq->subvendor)
+		if ((codec->subsystem_id & 0xffff0000) != (pq->subvendor << 16))
 			continue;
 		if (codec->vendor_id != pq->codec)
 			continue;
-- 
1.8.1.2
