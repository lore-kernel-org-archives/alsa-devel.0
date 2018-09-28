From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH alsa-lib] ioplug: Fix comment in struct
	snd_pcm_ioplug
Date: Fri, 28 Sep 2018 14:33:35 -0700
Message-ID: <20180928213335.16430-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CEA52678CA
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 23:34:02 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This patch fixes the comment about 'pcm' field in 'struct
snd_pcm_ioplug' which wrongly refers to snd_pcm_extplug_create().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 include/pcm_ioplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index b16fc8b8..81ac8613 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -105,7 +105,7 @@ struct snd_pcm_ioplug {
 	 */
 	void *private_data;
 	/**
-	 * PCM handle filled by #snd_pcm_extplug_create()
+	 * PCM handle filled by #snd_pcm_ioplug_create()
 	 */
 	snd_pcm_t *pcm;
 
-- 
2.14.4
