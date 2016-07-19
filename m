From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/3] topology: Check address and length before
	string copy
Date: Tue, 19 Jul 2016 16:52:48 +0800
Message-ID: <d19561c620efa5ed81692a7441b8fa7354a800d4.1468917665.git.mengdong.lin@linux.intel.com>
References: <cover.1468917665.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A7299266D0D
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 10:47:44 +0200 (CEST)
In-Reply-To: <cover.1468917665.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 4d79aa7..cfde4cc 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -253,6 +253,9 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 
 static inline void elem_copy_text(char *dest, const char *src, int len)
 {
+	if (!dest || !src || !len)
+		return;
+
 	strncpy(dest, src, len);
 	dest[len - 1] = 0;
 }
-- 
2.5.0
