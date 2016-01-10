From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hdac: couple the hda DMA stream in
	cleanup" to the asoc tree
Date: Sun, 10 Jan 2016 12:07:43 +0000
Message-ID: <E1aIEmd-0007PM-IV@debutante>
References: <1449816267-11910-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED1A2260614
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:48 +0100 (CET)
In-Reply-To: <1449816267-11910-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hdac: couple the hda DMA stream in cleanup

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

>From 88888155c555487037b894a97a2a4c6a8155cda0 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 18 Dec 2015 15:12:00 +0530
Subject: [PATCH] ALSA: hdac: couple the hda DMA stream in cleanup

A stream is by default in coupled mode, in DSP operation we move
it to decoupled mode. On cleanup HW expects that we leave it back
to default state so couple the DMA on cleanup.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/ext/hdac_ext_stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 8f30e8836818..023cc4cad5c1 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -111,6 +111,7 @@ void snd_hdac_stream_free_all(struct hdac_ext_bus *ebus)
 	while (!list_empty(&bus->stream_list)) {
 		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
 		stream = stream_to_hdac_ext_stream(s);
+		snd_hdac_ext_stream_decouple(ebus, stream, false);
 		list_del(&s->list);
 		kfree(stream);
 	}
-- 
2.7.0.rc3
