From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] [ALSA] hwdep: silence integer overflow
	warning
Date: Fri, 28 Oct 2011 09:46:01 +0300
Message-ID: <20111028064601.GB14707@longonot.mountain>
References: <20111020060910.GA6101@elgon.mountain>
 <4E9FD02B.6030307@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 5936B24759
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Oct 2011 08:48:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E9FD02B.6030307@bfs.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: walter harms <wharms@bfs.de>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Smatch complains that if device is INT_MAX then device + 1 can
overflow.  It just means we would have an annoying loop while we
check all the devices from -2147483648 to SNDRV_MINOR_HWDEPS.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: reshuffled it a bit per Walter Harms's suggestion.

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index c7ceb28..75ea16f 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -273,7 +273,14 @@ static int snd_hwdep_control_ioctl(struct snd_card *card,
 			if (get_user(device, (int __user *)arg))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
-			device = device < 0 ? 0 : device + 1;
+
+			if (device < 0)
+				device = 0;
+			else if (device < SNDRV_MINOR_HWDEPS)
+				device++;
+			else
+				device = SNDRV_MINOR_HWDEPS;
+
 			while (device < SNDRV_MINOR_HWDEPS) {
 				if (snd_hwdep_search(card, device))
 					break;
