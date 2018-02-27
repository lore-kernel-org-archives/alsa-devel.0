From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: control: Fix memory corruption risk in
	snd_ctl_elem_read
Date: Tue, 27 Feb 2018 17:01:18 +0000
Message-ID: <20180227170118.23197-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A8D052676C6
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 18:01:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE
operations" introduced a potential for kernel memory corruption due
to an incorrect if statement allowing non-readable controls to fall
through and call the get function. For TLV controls a driver can omit
SNDRV_CTL_ELEM_ACCESS_READ to ensure that only the TLV get function
can be called. Instead the normal get() can be invoked unexpectedly
and as the driver expects that this will only be called for controls
<= 512 bytes, potentially try to copy >512 bytes into the 512 byte
return array, so corrupting kernel memory.

The problem is an attempt to refactor the snd_ctl_elem_read function
to invert the logic so that it conditionally aborted if the control
is unreadable instead of conditionally executing. But the if statement
wasn't inverted correctly.

The correct inversion of

    if (a && !b)

is
    if (!a || b)

Fixes: becf9e5d553c2 ("ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0b3026d937b1..8a77620a3854 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -889,7 +889,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL)
 		return -EPERM;
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-- 
2.11.0
