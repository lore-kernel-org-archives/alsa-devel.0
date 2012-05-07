From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdsp - Provide ioctl_compat
Date: Mon,  7 May 2012 18:52:51 +0200
Message-ID: <1336409571-13371-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1336152952-21309-1-git-send-email-andre.schramm@iosono-sound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1336152952-21309-1-git-send-email-andre.schramm@iosono-sound.com>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

From: Andre Schramm <andre.schramm@iosono-sound.com>

snd_hdsp uses its own ioctls to acquire config- and status information.
Expose the corresponding ioctl handler via ioctl_compat, so that 32bit applications can use it on 64bit kernels.

Signed-off-by: Andre Schramm <andre.schramm@iosono-sound.com>
Reviewed-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 5cc31a4..0d6930c 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5170,6 +5170,7 @@ static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
 	strcpy(hw->name, "HDSP hwdep interface");
 
 	hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
+	hw->ops.ioctl_compat = snd_hdsp_hwdep_ioctl;
 
 	return 0;
 }
-- 
1.7.10
