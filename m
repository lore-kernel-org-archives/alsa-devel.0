From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH 1/4] pcm:file: add the missing htimestamp
	callback
Date: Thu, 12 Jun 2014 16:34:21 +0600
Message-ID: <1402569264-2789-2-git-send-email-patrakov@gmail.com>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C6DA26512D
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 12:34:45 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id s7so343753lbd.4
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 03:34:44 -0700 (PDT)
In-Reply-To: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
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
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
---
 src/pcm/pcm_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index b1f2330..b139f7f 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -697,6 +697,7 @@ static const snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
 	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_generic_poll_revents,
+	.htimestamp = snd_pcm_generic_real_htimestamp,
 };
 
 /**
-- 
2.0.0
