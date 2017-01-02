From: jeeja.kp@intel.com
Subject: [PATCH v4 1/9] ALSA: hda: check stream decoupled
	register state
Date: Mon,  2 Jan 2017 12:44:28 +0530
Message-ID: <1483341277-14475-2-git-send-email-jeeja.kp@intel.com>
References: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C092668BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 08:03:52 +0100 (CET)
In-Reply-To: <1483341277-14475-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Check stream decoupled register value with requested value
before decoupling/coupling the stream.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/ext/hdac_ext_stream.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 3be051ab5..c96d7a7 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -128,14 +128,17 @@ void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *ebus,
 {
 	struct hdac_stream *hstream = &stream->hstream;
 	struct hdac_bus *bus = &ebus->bus;
+	u32 val;
+	int mask = AZX_PPCTL_PROCEN(hstream->index);
 
 	spin_lock_irq(&bus->reg_lock);
-	if (decouple)
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, 0,
-				AZX_PPCTL_PROCEN(hstream->index));
-	else
-		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL,
-					AZX_PPCTL_PROCEN(hstream->index), 0);
+	val = readw(bus->ppcap + AZX_REG_PP_PPCTL) & mask;
+
+	if (decouple && !val)
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, mask, mask);
+	else if (!decouple && val)
+		snd_hdac_updatel(bus->ppcap, AZX_REG_PP_PPCTL, mask, 0);
+
 	stream->decoupled = decouple;
 	spin_unlock_irq(&bus->reg_lock);
 }
-- 
2.5.0
