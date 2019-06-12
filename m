From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 3/6] Don't return in a void function
Date: Tue, 11 Jun 2019 23:08:11 -0700
Message-ID: <20190612060814.13534-4-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22A57F896CE
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:21 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id j2so8977674pfe.6
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:21 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A return statement with an expression in a function returning void is
a constraint violation.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/pcm/pcm_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 77d4dae1..2028790e 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1171,7 +1171,7 @@ static void __fill_chmap_ctl_id(snd_ctl_elem_id_t *id, int dev, int subdev,
 static void fill_chmap_ctl_id(snd_pcm_t *pcm, snd_ctl_elem_id_t *id)
 {
 	snd_pcm_hw_t *hw = pcm->private_data;
-	return __fill_chmap_ctl_id(id, hw->device, hw->subdevice, pcm->stream);
+	__fill_chmap_ctl_id(id, hw->device, hw->subdevice, pcm->stream);
 }
 
 static int is_chmap_type(int type)
-- 
2.20.1
