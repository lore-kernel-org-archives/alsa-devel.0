From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/3] topology: Remove support for control flag
	SNDRV_CTL_ELEM_ACCESS_USER
Date: Tue, 19 Jul 2016 16:51:57 +0800
Message-ID: <58d24952d9582a9894c9e946033da6d84fd528bb.1468917665.git.mengdong.lin@linux.intel.com>
References: <cover.1468917665.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB43266C94
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 10:46:52 +0200 (CEST)
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

This access flag is used to add controls from user space by ioctl.
But topology only configures controls in user space and these controls
will still be created by ASoC in kernel, so topology should not support
this flag.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 592dded..54f8e44 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -41,7 +41,6 @@ static const struct ctl_access_elem ctl_access[] = {
 	{"lock", SNDRV_CTL_ELEM_ACCESS_LOCK},
 	{"owner", SNDRV_CTL_ELEM_ACCESS_OWNER},
 	{"tlv_callback", SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK},
-	{"user", SNDRV_CTL_ELEM_ACCESS_USER},
 };
 
 /* find CTL access strings and conver to values */
-- 
2.5.0
