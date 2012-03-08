From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Provide ioctl_compat
Date: Thu,  8 Mar 2012 15:38:04 +0100
Message-ID: <1331217484-4206-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1331217484-4206-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1331217484-4206-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_hdspm uses its own ioctls to acquire config- and status information.
Expose the corresponding ioctl handler via ioctl_compat, so that 32bit
applications can use it on 64bit kernels.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 942cbe6..603cfc5 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6345,6 +6345,7 @@ static int __devinit snd_hdspm_create_hwdep(struct snd_card *card,
 
 	hw->ops.open = snd_hdspm_hwdep_dummy_op;
 	hw->ops.ioctl = snd_hdspm_hwdep_ioctl;
+	hw->ops.ioctl_compat = snd_hdspm_hwdep_ioctl;
 	hw->ops.release = snd_hdspm_hwdep_dummy_op;
 
 	return 0;
-- 
1.7.9.1
