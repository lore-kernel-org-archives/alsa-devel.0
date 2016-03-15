From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/6] ALSA: hda: use list macro for parsing on
	cleanup
Date: Tue, 15 Mar 2016 15:27:11 +0530
Message-ID: <1458035836-1843-2-git-send-email-vinod.koul@intel.com>
References: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 78B792612AE
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:53:07 +0100 (CET)
In-Reply-To: <1458035836-1843-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

It is always better to use list_for_each_entry_safe() while doing
cleanup. So use this instead of open coding this in list in
snd_hdac_stream_free_all()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 023cc4cad5c1..626f3bb24c55 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -104,12 +104,11 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init_all);
  */
 void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus)
 {
-	struct hdac_stream *s;
+	struct hdac_stream *s, *_s;
 	struct hdac_ext_stream *stream;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 
-	while (!list_empty(&bus->stream_list)) {
-		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
+	list_for_each_entry_safe(s, _s, &bus->stream_list, list) {
 		stream = stream_to_hdac_ext_stream(s);
 		snd_hdac_ext_stream_decouple(ebus, stream, false);
 		list_del(&s->list);
-- 
1.9.1
