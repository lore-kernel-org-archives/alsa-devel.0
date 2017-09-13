From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: hwdep: prevent a harmless shift wrapping
	bug
Date: Thu, 14 Sep 2017 02:01:16 +0300
Message-ID: <20170913230116.yspku7ov2hgqtigh@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id B0EA9267168
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 01:01:38 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The "info.index" variable represents a bit in hw->dsp_loaded which is
an unsigned int.  If it's higher than 31 we hit a shift wrapping bug.
This seems harmless, but I wanted to silence the static checker warning.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index a73baa1242be..8faae3d1455d 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -228,6 +228,8 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 	memset(&info, 0, sizeof(info));
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
+	if (info.index >= 32)
+		return -EINVAL;
 	/* check whether the dsp was already loaded */
 	if (hw->dsp_loaded & (1 << info.index))
 		return -EBUSY;
