From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 3/5] ALSA: revo: Remove unused variable
Date: Tue,  1 Jul 2014 17:02:56 +0530
Message-ID: <1404214378-24669-3-git-send-email-sachin.kamat@samsung.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FDEE261B08
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:36:36 +0200 (CEST)
Received: by mail-pa0-f53.google.com with SMTP id ey11so10432956pad.12
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 04:36:36 -0700 (PDT)
In-Reply-To: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
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
Cc: tiwai@suse.de, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

'err' is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/pci/ice1712/revo.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 1112ec1953be..0168aaa5f58c 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -481,7 +481,6 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
 	static const unsigned char ak4114_init_txcsb[] = {
 		0x41, 0x02, 0x2c, 0x00, 0x00
 	};
-	int err;
 
 	struct revo51_spec *spec;
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -489,7 +488,7 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
 		return -ENOMEM;
 	ice->spec = spec;
 
-	err = snd_ak4114_create(ice->card,
+	snd_ak4114_create(ice->card,
 				 ap192_ak4114_read,
 				 ap192_ak4114_write,
 				 ak4114_init_vals, ak4114_init_txcsb,
-- 
1.7.9.5
