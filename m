From: Renu Tyagi <renu.tyagi@samsung.com>
Subject: [PATCH v2 02/11] pcm_file : fixed missing free
Date: Tue, 23 Sep 2014 04:18:17 +0000 (GMT)
Message-ID: <15498010.61181411445897166.JavaMail.weblogic@epv6ml10>
Reply-To: renu.tyagi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 7546F261AA5
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 06:18:41 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCC00F026MSMGD0@mailout3.samsung.com> for
 alsa-devel@alsa-project.org; Tue, 23 Sep 2014 13:18:29 +0900 (KST)
MIME-version: 1.0
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: renu tyagi <renu.tyagi@samsung.com>
---
 src/pcm/pcm_file.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index a0b8bf4..f6d222f 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -758,6 +758,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
                ifd = open(ifname, O_RDONLY);   /* TODO: mind blocking mode */
                if (ifd < 0) {
                        SYSERR("open %s for reading failed", ifname);
+                       free(file->fname);
                        free(file);
                        return -errno;
                }
@@ -772,6 +773,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
        err = snd_pcm_new(&pcm, SND_PCM_TYPE_FILE, name, slave->stream, slave->mode);
        if (err < 0) {
                free(file->fname);
+               free(file->ifname);
                free(file);
                return err;
        }
--
1.7.1
