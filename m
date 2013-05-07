From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH]ALSA: HDA: Fix Oops caused by dereference NULL pointer
Date: Tue, 7 May 2013 11:27:33 +0800
Message-ID: <20130507032733.GA29944@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@perex.cz, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

The interrupt handler azx_interrupt will call azx_update_rirb,
which may call snd_hda_queue_unsol_event, snd_hda_queue_unsol_event
will dereference chip->bus pointer.

The problem is we alloc chip->bus in azx_codec_create
which will be called after we enable IRQ and enable unsolicited
event in azx_probe.

This will cause Oops due dereference NULL pointer. I meet it, good luck:)

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 sound/pci/hda/hda_codec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 622f726..9c76752 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -618,6 +618,9 @@ int snd_hda_queue_unsol_event(struct hda_bus *bus, u32 res, u32 res_ex)
 	unsigned int wp;
 
 	trace_hda_unsol_event(bus, res, res_ex);
+	if (!bus)
+		return 0;
+
 	unsol = bus->unsol;
 	if (!unsol)
 		return 0;
-- 
1.7.12.4.dirty
