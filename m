From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] sound: memalloc.c: Fix build warnings
Date: Mon, 16 Jan 2012 01:02:02 -0200
Message-ID: <1326682922-20884-1-git-send-email-festevam@gmail.com>
Content-Type: multipart/mixed; boundary="===============3911950323605098962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C2ACB103807
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 04:02:22 +0100 (CET)
Received: by yenl11 with SMTP id l11so964539yen.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 19:02:20 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Fabio Estevam <fabio.estevam@freescale.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============3911950323605098962==

Fix the following build warnings:

sound/core/memalloc.c: In function ‘snd_mem_proc_write’:
sound/core/memalloc.c:426: warning: ‘vendor’ may be used uninitialized in this function
sound/core/memalloc.c:426: warning: ‘device’ may be used uninitialized in this function
sound/core/memalloc.c:426: warning: ‘size’ may be used uninitialized in this function
sound/core/memalloc.c:426: warning: ‘buffers’ may be used uninitialized in this function
sound/core/memalloc.c:427: warning: ‘mask’ may be used uninitialized in this function

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/core/memalloc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 6915692..7dbad80 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -423,8 +423,11 @@ static ssize_t snd_mem_proc_write(struct file *file, const char __user * buffer,
 		return count;
 	if (strcmp(token, "add") == 0) {
 		char *endp;
-		int vendor, device, size, buffers;
-		long mask;
+		int vendor = 0;
+		int device = 0;
+		int size = 0; 
+		int buffers = 0;
+		long mask = 0;
 		int i, alloced;
 		struct pci_dev *pci;
 
-- 
1.7.1


--===============3911950323605098962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3911950323605098962==--
