From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Update model list
	documentation for IDT codecs
Date: Tue, 15 Jul 2014 17:01:50 +0200
Message-ID: <1405436510-16848-2-git-send-email-tiwai@suse.de>
References: <1405436510-16848-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 030C3261683
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 17:01:50 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B1584AC3A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 15:01:50 +0000 (UTC)
In-Reply-To: <1405436510-16848-1-git-send-email-tiwai@suse.de>
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

Just add missing recent entries.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/alsa/HD-Audio-Models.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index d1ab5e17eb13..a5e754714344 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -284,6 +284,11 @@ STAC92HD83*
   hp-zephyr	HP Zephyr
   hp-led	HP with broken BIOS for mute LED
   hp-inv-led	HP with broken BIOS for inverted mute LED
+  hp-mic-led	HP with mic-mute LED
+  headset-jack	Dell Latitude with a 4-pin headset jack
+  hp-envy-bass	Pin fixup for HP Envy bass speaker (NID 0x0f)
+  hp-envy-ts-bass Pin fixup for HP Envy TS bass speaker (NID 0x10)
+  hp-bnb13-eq	Hardware equalizer setup for HP laptops
   auto		BIOS setup (default)
 
 STAC92HD95
-- 
2.0.1
