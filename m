From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] [ALSA] sb16 - info leak in snd_sb_csp_ioctl()
Date: Thu, 7 Nov 2013 11:09:54 +0300
Message-ID: <20131107080954.GS21844@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D86F2610A8
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 09:10:05 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a 2 byte hole after "info.func_nr" so we could leak unitialized
stack information to userspace.

Fixes: 1da177e4c3f4 ('Linux-2.6.12-rc2')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index c1aa21e..48da227 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -208,6 +208,7 @@ static int snd_sb_csp_ioctl(struct snd_hwdep * hw, struct file *file, unsigned i
 	switch (cmd) {
 		/* get information */
 	case SNDRV_SB_CSP_IOCTL_INFO:
+		memset(&info, 0, sizeof(info));
 		*info.codec_name = *p->codec_name;
 		info.func_nr = p->func_nr;
 		info.acc_format = p->acc_format;
