From: Michael Forney <mforney@mforney.org>
Subject: [PATCH] pcm_plug: Clear plugins on all error conditions
Date: Wed, 19 Oct 2016 18:22:56 -0700
Message-ID: <1476926576-16679-1-git-send-email-mforney@mforney.org>
References: <s5hzim0ds8v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C22F2665FC
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 03:24:13 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id s8so3873263pfj.2
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 18:24:13 -0700 (PDT)
In-Reply-To: <s5hzim0ds8v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Otherwise, they will linger after the error is returned (but pcm->setup == 0).
Then, if the caller tries to clean up and call snd_pcm_close(), the assertion
plug->gen.slave == plug->req_slave will fail.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/pcm/pcm_plug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index 5639b9e..266707b 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -652,8 +652,10 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
 	       (plug->ttable && !plug->ttable_ok)) {
 		snd_pcm_t *new;
 		int err;
-		if (k >= sizeof(funcs)/sizeof(*funcs))
+		if (k >= sizeof(funcs)/sizeof(*funcs)) {
+			snd_pcm_plug_clear(pcm);
 			return -EINVAL;
+		}
 		err = funcs[k](pcm, &new, client, &p);
 		if (err < 0) {
 			snd_pcm_plug_clear(pcm);
-- 
2.10.1
