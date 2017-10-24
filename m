From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda controller - handle -1 value as
	error in snd_hdac_bus_parse_capabilities()
Date: Tue, 24 Oct 2017 18:56:47 +0200
Message-ID: <20171024165647.8417-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E0F266DB1
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 18:57:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

We have seen this value on a development platform.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/hda/hdac_controller.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 978dc1801b3a..4a1823290b2d 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -278,6 +278,11 @@ int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
 	do {
 		cur_cap = _snd_hdac_chip_readl(bus, offset);
 
+		if (cur_cap == 0xffffffff) {
+			dev_dbg(bus->dev, "Wrong capability -1\n");
+			break;
+		}
+
 		dev_dbg(bus->dev, "Capability version: 0x%x\n",
 			(cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF);
 
-- 
2.13.6
