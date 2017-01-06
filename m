From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda: check stream decoupled register
	state" to the asoc tree
Date: Fri, 06 Jan 2017 18:16:26 +0000
Message-ID: <E1cPZ3y-00036u-Us@debutante>
References: <1481184684-9620-6-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A3712677FE
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:36 +0100 (CET)
In-Reply-To: <1481184684-9620-6-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda: check stream decoupled register state

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

>From 09a8bf812c662c833621f19955a1d3fa495801bc Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 2 Jan 2017 12:44:28 +0530
Subject: [PATCH] ALSA: hda: check stream decoupled register state

Check stream decoupled register value with requested value
before decoupling/coupling the stream.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Acked-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/hda/ext/hdac_ext_stream.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 3be051ab5533..c96d7a7a36af 100644
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
2.11.0
