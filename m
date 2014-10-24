From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: mrfld - Define ipc_info
	structure
Date: Fri, 24 Oct 2014 13:49:47 +0530
Message-ID: <1414138788-4632-3-git-send-email-vinod.koul@intel.com>
References: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D30F92604C5
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 10:59:41 +0200 (CEST)
In-Reply-To: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

This will be used to abstract the differances in ipc offsets for different
chips.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 268a96a..6021dee 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -102,6 +102,11 @@ struct sst_lib_dnld_info {
 	bool mod_ddr_dnld;
 };
 
+struct sst_ipc_info {
+	int ipc_offset;
+	unsigned int mbox_recv_off;
+};
+
 struct sst_platform_info {
 	const struct sst_info *probe_data;
 	const struct sst_ipc_info *ipc_info;
-- 
1.7.0.4
