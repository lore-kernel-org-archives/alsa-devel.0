From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: trace: Make sure trace header doesnt
	depend on any headers
Date: Fri, 13 Sep 2013 18:09:46 +0100
Message-ID: <1379092188-7385-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7424E2610A4
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:10:02 +0200 (CEST)
In-Reply-To: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix build so that asoc trace event header doesn't depend on other headers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/trace/events/asoc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 5fc2dcd..03996b2 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -14,6 +14,7 @@ struct snd_soc_codec;
 struct snd_soc_platform;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
+struct snd_soc_dapm_path;
 
 /*
  * Log register events
-- 
1.8.1.2
