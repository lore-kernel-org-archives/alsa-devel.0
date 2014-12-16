From: Kevin Strasser <kevin.strasser@linux.intel.com>
Subject: [PATCH v2] ASoC: Intel: fix possible acpi enumeration panic
Date: Mon, 15 Dec 2014 16:15:04 -0800
Message-ID: <1418688904-26959-1-git-send-email-kevin.strasser@linux.intel.com>
References: <1418282517-851-1-git-send-email-kevin.strasser@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418282517-851-1-git-send-email-kevin.strasser@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Mengdong Lin <mengdong.lin@intel.com>, Yang Fang <yang.a.fang@intel.com>, linux-kernel@vger.kernel.org, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

A crash can occur on some platforms where adsp is enumerated but codec is not
matched. Define codec_id as a pointer intead of an array so that it gets
initialized to NULL for the terminating element of sst_acpi_bytcr[] and
sst_acpi_chv[].

Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>
---
 sound/soc/intel/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 31124aa..87b5090 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -43,7 +43,7 @@
 #include "sst.h"
 
 struct sst_machines {
-	char codec_id[32];
+	char *codec_id;
 	char board[32];
 	char machine[32];
 	void (*machine_quirk)(void);
-- 
1.9.1
