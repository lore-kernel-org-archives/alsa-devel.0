From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH v2] control_hw: Fix issue when applying seccomp
	policy
Date: Fri, 17 Aug 2018 11:12:27 +0800
Message-ID: <20180817031227.187676-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id F0FFF267812
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2018 05:12:35 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so3047900plb.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2018 20:12:35 -0700 (PDT)
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
Cc: vinod.koul@intel.com, dgreid@chromium.org, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

When seccomp policy is applied to filter ioctl syscall with
SNDRV_CTL_IOCTL_TLV_COMMAND, SNDRV_CTL_IOCTL_TLV_READ and
SNDRV_CTL_IOCTL_TLV_WRITE in whiltelist, alsa-lib still breaks
in at snd_ctl_hw_elem_tlv().

The problem behind is because ioctl() takes unsigned long cmd
argument, and the signed bit of local int variable could cause
0xff bytes appended after casted to unsigned long.
In kernel, seccomp data struct takes 64 bits argument to check
against seccomp rules, these unexpected 0xff bytes could make
the rule check fail.

Fix the problem by passing unsigned int to ioctl.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 src/control/control_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/control_hw.c b/src/control/control_hw.c
index 68eca522..b54d65f2 100644
--- a/src/control/control_hw.c
+++ b/src/control/control_hw.c
@@ -215,7 +215,7 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
 			       unsigned int numid,
 			       unsigned int *tlv, unsigned int tlv_size)
 {
-	int inum;
+	unsigned int inum;
 	snd_ctl_hw_t *hw = handle->private_data;
 	struct snd_ctl_tlv *xtlv;
 	
-- 
2.18.0.865.gffc8e1a3cd6-goog
