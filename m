From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: skl: Fix kernel warning due to zero NHTL
	entry
Date: Wed,  3 Jan 2018 16:38:46 +0100
Message-ID: <20180103153846.6106-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DDC326765B
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 16:38:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

I got the following kernel warning when loading snd-soc-skl module on
Dell Latitude 7270 laptop:
 memremap attempted on mixed range 0x0000000000000000 size: 0x0
 WARNING: CPU: 0 PID: 484 at kernel/memremap.c:98 memremap+0x8a/0x180
 Call Trace:
  skl_nhlt_init+0x82/0xf0 [snd_soc_skl]
  skl_probe+0x2ee/0x7c0 [snd_soc_skl]
  ....

It seems that the machine doesn't support the SKL DSP gives the empty
NHLT entry, and it triggers the warning.  For avoiding it, let do the
zero check before calling memremap().

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/skylake/skl-nhlt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index ba265119e0a1..9dd77383a4a7 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -44,7 +44,8 @@ struct nhlt_acpi_table *skl_nhlt_init(struct device *dev)
 	obj = acpi_evaluate_dsm(handle, &osc_guid, 1, 1, NULL);
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-		nhlt_table = (struct nhlt_acpi_table *)
+		if (nhlt_ptr->length)
+			nhlt_table = (struct nhlt_acpi_table *)
 				memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				MEMREMAP_WB);
 		ACPI_FREE(obj);
-- 
2.15.1
