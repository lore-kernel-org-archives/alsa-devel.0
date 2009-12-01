From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] ASoC: au1x: dbdma2: plug memleak in pcm
	device creation error path
Date: Tue,  1 Dec 2009 18:10:35 +0100
Message-ID: <1259687435-7066-3-git-send-email-manuel.lauss@gmail.com>
References: <1259687435-7066-1-git-send-email-manuel.lauss@gmail.com>
	<1259687435-7066-2-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f211.google.com (mail-fx0-f211.google.com
	[209.85.220.211])
	by alsa0.perex.cz (Postfix) with ESMTP id D797C2414C
	for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2009 18:10:28 +0100 (CET)
Received: by mail-fx0-f211.google.com with SMTP id 3so3994761fxm.4
	for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2009 09:10:28 -0800 (PST)
In-Reply-To: <1259687435-7066-2-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

free the allocated pcm platform device in the error path.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 sound/soc/au1x/dbdma2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 148e205..6d9f4c6 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -478,6 +478,7 @@ struct platform_device *au1xpsc_pcm_add(struct platform_device *pdev)
 	if (!ret)
 		return pd;
 
+	platform_device_put(pd);
 out:
 	kfree(res);
 	return NULL;
-- 
1.6.5.3
