From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/2] ASoC: Intel: Skylake: set
	.ignore_module_refcount field in component
Date: Fri,  1 Feb 2019 11:22:24 -0600
Message-ID: <20190201172224.14549-3-pierre-louis.bossart@linux.intel.com>
References: <20190201172224.14549-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE15267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 18:22:43 +0100 (CET)
In-Reply-To: <20190201172224.14549-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no risk of the module being removed while the platform
components are in use. This solves the problem of the snd_soc_skl
module not being removable with rmmod

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8e589d698c58..a4284778f117 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1464,6 +1464,7 @@ static const struct snd_soc_component_driver skl_component  = {
 	.ops		= &skl_platform_ops,
 	.pcm_new	= skl_pcm_new,
 	.pcm_free	= skl_pcm_free,
+	.ignore_module_refcount = 1, /* do not increase the refcount in core */
 };
 
 int skl_platform_register(struct device *dev)
-- 
2.17.1
