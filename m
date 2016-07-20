From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/3] topology: Remove support for control
	flag SNDRV_CTL_ELEM_ACCESS_USER
Date: Wed, 20 Jul 2016 09:52:52 +0800
Message-ID: <76d5196edf624917f3f7da5c94bd2223b2988d0c.1468979281.git.mengdong.lin@linux.intel.com>
References: <cover.1468979281.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 22555265928
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 03:47:47 +0200 (CEST)
In-Reply-To: <cover.1468979281.git.mengdong.lin@linux.intel.com>
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
will eventually be created by ASoC in kernel, so topology should not
support this flag.

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
