From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Fix substream
	dereference before check
Date: Fri, 30 Oct 2015 20:34:20 +0530
Message-ID: <1446217461-2106-4-git-send-email-vinod.koul@intel.com>
References: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A446261643
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 16:01:38 +0100 (CET)
In-Reply-To: <1446217461-2106-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Smatch warns that we dereferenced substream before check, so fix
this by initializing ebus after the check

sound/soc/intel/skylake/skl-pcm.c:802 skl_get_position()
        warn: variable dereferenced before check 'substream->runtime'

Reported by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 2517ec576ffc..e652d58bd9a9 100644
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
1.9.1
