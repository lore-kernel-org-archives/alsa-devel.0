From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda: use list macro for parsing on
	cleanup" to the asoc tree
Date: Wed, 16 Mar 2016 10:09:23 +0000
Message-ID: <E1ag8OJ-00063K-PO@debutante>
References: <1458035836-1843-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33621265E0E
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:09:33 +0100 (CET)
In-Reply-To: <1458035836-1843-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda: use list macro for parsing on cleanup

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4a6c5e6a8d29e4d33858227db9179e91aa8a7407 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Mar 2016 16:39:23 +0530
Subject: [PATCH] ALSA: hda: use list macro for parsing on cleanup

It is always better to use list_for_each_entry_safe() while doing
cleanup. So use this instead of open coding this in list in
snd_hdac_stream_free_all()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0
