From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 7/8] ALSA: hdspm - prevent reading unitialized
	stack memory
Date: Wed, 23 Feb 2011 11:43:14 +0100
Message-ID: <1298457795-28114-8-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Original patch by Dan Rosenberg <drosenberg@vsecurity.com> under commit
e68d3b316ab7b02a074edc4f770e6a746390cb7d. I'm copying his text here:

The SNDRV_HDSPM_IOCTL_GET_CONFIG_INFO ioctl in hdspm.c allow unprivileged
users to read uninitialized kernel stack memory, because several fields
of the hdspm_config struct declared on the stack are not altered
or zeroed before being copied back to the user.  This patch takes care
of it.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 0b0293f..ced1406 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6081,6 +6081,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 
 	case SNDRV_HDSPM_IOCTL_GET_CONFIG:
 
+		memset(&info, 0, sizeof(info));
 		spin_lock_irq(&hdspm->lock);
 		info.pref_sync_ref = hdspm_pref_sync_ref(hdspm);
 		info.wordclock_sync_check = hdspm_wc_sync_check(hdspm);
-- 
1.7.2.3
