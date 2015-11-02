From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix substream
	dereference before check" to the asoc tree
Date: Mon, 02 Nov 2015 10:39:43 +0000
Message-ID: <E1ZtCWd-0006DN-A8@finisterre>
References: <1446217461-2106-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E1C92607C8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 11:39:54 +0100 (CET)
In-Reply-To: <1446217461-2106-4-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix substream dereference before check

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

>From 5802b6ab6cb499739beb9de8643d2b7b2c2ae00a Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 30 Oct 2015 20:34:20 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix substream dereference before check

Smatch warns that we dereferenced substream before check, so fix
this by initializing ebus after the check

sound/soc/intel/skylake/skl-pcm.c:802 skl_get_position()
        warn: variable dereferenced before check 'substream->runtime'

Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2517ec5..e652d58 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -807,7 +807,7 @@ static unsigned int skl_get_position(struct hdac_ext_stream *hstream,
 {
 	struct hdac_stream *hstr = hdac_stream(hstream);
 	struct snd_pcm_substream *substream = hstr->substream;
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_ext_bus *ebus;
 	unsigned int pos;
 	int delay;
 
@@ -818,6 +818,7 @@ static unsigned int skl_get_position(struct hdac_ext_stream *hstream,
 		pos = 0;
 
 	if (substream->runtime) {
+		ebus = get_bus_ctx(substream);
 		delay = skl_get_delay_from_lpib(ebus, hstream, pos)
 						 + codec_delay;
 		substream->runtime->delay += delay;
-- 
2.6.1
