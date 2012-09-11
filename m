From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: compress_core: fix open flags test in
	snd_compr_open()
Date: Tue, 11 Sep 2012 14:12:43 +0300
Message-ID: <20120911111243.GC22259@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 71CA326156C
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 13:12:54 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jesper Juhl <jj@chaosbits.net>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

O_RDONLY is zero so the original test (f->f_flags & O_RDONLY) is always
false and it will never do compress capture.  The test for O_WRONLY is
also slightly off.  The original test would consider "->flags =
(O_WRONLY | O_RDWR)" as write only instead of rejecting it as invalid.

I've also removed the pr_err() because that could flood dmesg.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index ec2118d..eb60cb8 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -80,14 +80,12 @@ static int snd_compr_open(struct inode *inode, struct file *f)
 	int maj = imajor(inode);
 	int ret;
 
-	if (f->f_flags & O_WRONLY)
+	if ((f->f_flags & O_ACCMODE) == O_WRONLY)
 		dirn = SND_COMPRESS_PLAYBACK;
-	else if (f->f_flags & O_RDONLY)
+	else if ((f->f_flags & O_ACCMODE) == O_RDONLY)
 		dirn = SND_COMPRESS_CAPTURE;
-	else {
-		pr_err("invalid direction\n");
+	else
 		return -EINVAL;
-	}
 
 	if (maj == snd_major)
 		compr = snd_lookup_minor_data(iminor(inode),
