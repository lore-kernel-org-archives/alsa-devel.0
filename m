From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH 11/15] pci: echoaudio: check kmalloc() result
Date: Fri, 16 Jul 2010 20:15:43 +0400
Message-ID: <1279296943-25187-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Giuliano Pochini <pochini@shiny.it>, Julia Lawall <julia@diku.dk>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If kmalloc() fails exit with -ENOMEM.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/pci/echoaudio/echoaudio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 668a5ec..20763dd 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2250,6 +2250,8 @@ static int snd_echo_resume(struct pci_dev *pci)
 	DE_INIT(("resume start\n"));
 	pci_restore_state(pci);
 	commpage_bak = kmalloc(sizeof(struct echoaudio), GFP_KERNEL);
+	if (commpage_bak == NULL)
+		return -ENOMEM;
 	commpage = chip->comm_page;
 	memcpy(commpage_bak, commpage, sizeof(struct comm_page));
 
-- 
1.7.0.4
