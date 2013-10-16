From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hdsp - info leak in
	snd_hdsp_hwdep_ioctl()
Date: Wed, 16 Oct 2013 11:44:25 +0300
Message-ID: <20131016084425.GA6287@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id BA69C265071
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 10:49:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Adrian Knoth <adi@drcomp.erfurt.thur.de>, Bill Pemberton <wfp5p@virginia.edu>, speiro@ai2.upv.es
List-Id: alsa-devel@alsa-project.org

In GCC the sizeof(hdsp_version) is 8 because there is a 2 byte hole at
the end of the struct after ->firmware_rev.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4f255df..f59a321 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -4845,6 +4845,7 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 			if ((err = hdsp_get_iobox_version(hdsp)) < 0)
 				return err;
 		}
+		memset(&hdsp_version, 0, sizeof(hdsp_version));
 		hdsp_version.io_type = hdsp->io_type;
 		hdsp_version.firmware_rev = hdsp->firmware_rev;
 		if ((err = copy_to_user(argp, &hdsp_version, sizeof(hdsp_version))))
