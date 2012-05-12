From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH alsa-lib 1/1] fix: add missing "break" in
	"switch"
Date: Sun, 13 May 2012 00:06:23 +0800
Message-ID: <1336838783-30686-2-git-send-email-borneo.antonio@gmail.com>
References: <1336838783-30686-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id A69AB243AC
	for <alsa-devel@alsa-project.org>;
	Sat, 12 May 2012 18:07:07 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so6017959pbb.38
	for <alsa-devel@alsa-project.org>; Sat, 12 May 2012 09:07:06 -0700 (PDT)
In-Reply-To: <1336838783-30686-1-git-send-email-borneo.antonio@gmail.com>
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
List-Id: alsa-devel@alsa-project.org

A missing "break" in procedure snd_pcm_write_mmap() causes
execution of "case SND_PCM_ACCESS_MMAP_NONINTERLEAVED" to
fall through next "default" case of the "switch" statement.
Since "default" handles error cases, the procedure returns
error.

The error fixed by this patch blocks transfer of capture
data from kernel to application. Execution get stuck in
alsa-lib, that discards all received data.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 src/pcm/pcm_mmap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/pcm/pcm_mmap.c b/src/pcm/pcm_mmap.c
index 6b44050..83e74e5 100644
--- a/src/pcm/pcm_mmap.c
+++ b/src/pcm/pcm_mmap.c
@@ -622,6 +622,7 @@ snd_pcm_sframes_t snd_pcm_read_mmap(snd_pcm_t *pcm, snd_pcm_uframes_t offset,
 			err = _snd_pcm_readn(pcm->fast_op_arg, bufs, frames);
 			if (err >= 0)
 				frames = err;
+			break;
 		}
 		default:
 			SNDMSG("invalid access type %d", pcm->access);
-- 
1.7.3.4
