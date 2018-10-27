From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/3] soundwire: intel: constify snd_soc_dai_ops
	structures
Date: Sat, 27 Oct 2018 15:34:42 +0200
Message-ID: <1540647284-26728-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DB7C2679FD
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2018 16:10:05 +0200 (CEST)
In-Reply-To: <1540647284-26728-1-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/soundwire/intel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c5ee97ee7886..fd8d034cfec1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -654,14 +654,14 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 	return cdns_set_sdw_stream(dai, stream, false, direction);
 }
 
-static struct snd_soc_dai_ops intel_pcm_dai_ops = {
+static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
 	.shutdown = sdw_cdns_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
 };
 
-static struct snd_soc_dai_ops intel_pdm_dai_ops = {
+static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.hw_free = intel_hw_free,
 	.shutdown = sdw_cdns_shutdown,
