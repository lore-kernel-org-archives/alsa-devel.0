From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add shutdown callback"
	to the asoc tree
Date: Mon, 08 Feb 2016 18:01:32 +0000
Message-ID: <E1aSq7w-0002k2-8v@debutante>
References: <1454654950-23091-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67A2B261298
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2016 19:01:42 +0100 (CET)
In-Reply-To: <1454654950-23091-7-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add shutdown callback

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

>From c5a76a246989c8155d372142089ccfc9dc022388 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 5 Feb 2016 12:19:09 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add shutdown callback

While going to shutdown, we need to bring HW to clean state. This
is done by cleaning up stream descriptor registers. This cleanup
is already done by decoupling of stream and stopping the chip, so
invoke these from shutdown handler.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 092705e73db4..06f4b2c13423 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -634,6 +634,31 @@ out_free:
 	return err;
 }
 
+static void skl_shutdown(struct pci_dev *pci)
+{
+	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_stream *s;
+	struct hdac_ext_stream *stream;
+	struct skl *skl;
+
+	if (ebus == NULL)
+		return;
+
+	skl = ebus_to_skl(ebus);
+
+	if (skl->init_failed)
+		return;
+
+	snd_hdac_ext_stop_streams(ebus);
+	list_for_each_entry(s, &bus->stream_list, list) {
+		stream = stream_to_hdac_ext_stream(s);
+		snd_hdac_ext_stream_decouple(ebus, stream, false);
+	}
+
+	snd_hdac_bus_stop_chip(bus);
+}
+
 static void skl_remove(struct pci_dev *pci)
 {
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
@@ -677,6 +702,7 @@ static struct pci_driver skl_driver = {
 	.id_table = skl_ids,
 	.probe = skl_probe,
 	.remove = skl_remove,
+	.shutdown = skl_shutdown,
 	.driver = {
 		.pm = &skl_pm,
 	},
-- 
2.7.0.rc3
