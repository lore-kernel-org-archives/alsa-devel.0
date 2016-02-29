From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 2/3] Use pid_t,
	off_t instead of __kernel_*_t for better portability.
Date: Mon, 29 Feb 2016 16:05:20 +0100
Message-ID: <1456758321-2256-2-git-send-email-tk@giga.or.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-3.mx.upcmail.net
 (vie01a-dmta-pe02-3.mx.upcmail.net [62.179.121.159])
 by alsa0.perex.cz (Postfix) with ESMTP id 93A07260535
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:22:11 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1aaPeF-0002Gu-9Q
 for alsa-devel@alsa-project.org; Mon, 29 Feb 2016 16:22:11 +0100
In-Reply-To: <1456758321-2256-1-git-send-email-tk@giga.or.at>
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
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

---
 include/sound/asound.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index a82108e..4f2202f 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -415,7 +415,7 @@ struct snd_pcm_sw_params {
 
 struct snd_pcm_channel_info {
 	unsigned int channel;
-	__kernel_off_t offset;		/* mmap offset */
+	off_t offset;			/* mmap offset */
 	unsigned int first;		/* offset to first sample in bits */
 	unsigned int step;		/* samples distance in bits */
 };
@@ -884,7 +884,7 @@ struct snd_ctl_elem_info {
 	snd_ctl_elem_type_t type;	/* R: value type - SNDRV_CTL_ELEM_TYPE_* */
 	unsigned int access;		/* R: value access (bitmask) - SNDRV_CTL_ELEM_ACCESS_* */
 	unsigned int count;		/* count of values */
-	__kernel_pid_t owner;		/* owner's PID of this control */
+	pid_t owner;			/* owner's PID of this control */
 	union {
 		struct {
 			long min;		/* R: minimum value */
-- 
2.7.1
