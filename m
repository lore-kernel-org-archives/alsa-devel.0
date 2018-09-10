From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emu10k1: fix possible info leak to
	userspace on SNDRV_EMU10K1_IOCTL_INFO
Date: Mon, 10 Sep 2018 17:19:32 +0200
Message-ID: <20180910151932.17300-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 394C82676ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 17:19:57 +0200 (CEST)
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
Cc: Willy Tarreau <w@1wt.eu>, Jann Horn <jannh@google.com>
List-Id: alsa-devel@alsa-project.org

From: Willy Tarreau <w@1wt.eu>

snd_emu10k1_fx8010_ioctl(SNDRV_EMU10K1_IOCTL_INFO) allocates
memory using kmalloc() and partially fills it by calling
snd_emu10k1_fx8010_info() before returning the resulting
structure to userspace, leaving uninitialized holes. Let's
just use kzalloc() here.

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Signed-off-by: Willy Tarreau <w@1wt.eu>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emufx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 90713741c2dc..6ebe817801ea 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2540,7 +2540,7 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_hwdep * hw, struct file *file, un
 		emu->support_tlv = 1;
 		return put_user(SNDRV_EMU10K1_VERSION, (int __user *)argp);
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 		snd_emu10k1_fx8010_info(emu, info);
-- 
2.18.0
