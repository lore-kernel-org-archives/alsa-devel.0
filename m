From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Print module type instead of id
Date: Tue, 27 Aug 2019 16:17:10 +0200
Message-ID: <20190827141712.21015-5-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

When we are printing module params, we were actually printing module id
instead of type, but debug message was saying that number we get is type.
So print module type, as it is useful when debugging paths, but also
keep printing module id, as it is used in all other logs.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index d43496c5f29e..476ef1897961 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -867,8 +867,9 @@ static int skl_set_module_format(struct skl_dev *skl,
 
 	}
 
-	dev_dbg(skl->dev, "Module type=%d config size: %d bytes\n",
-			module_config->id.module_id, param_size);
+	dev_dbg(skl->dev, "Module type=%d id=%d config size: %d bytes\n",
+			module_config->m_type, module_config->id.module_id,
+			param_size);
 	print_hex_dump_debug("Module params:", DUMP_PREFIX_OFFSET, 8, 4,
 			*param_data, param_size, false);
 	return 0;
-- 
2.17.1
