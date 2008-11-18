From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 5/8] ASoC: Fix BUGS in Blackfin AC97 DAI
Date: Tue, 18 Nov 2008 16:18:19 +0800
Message-ID: <1226996302-10234-6-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id E878A1037EF
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:17:01 +0100 (CET)
In-Reply-To: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Michael Hennerich <michael.hennerich@analog.com>

sport_handle is a global and not allocated my kmalloc.
A probe function should have a clean return 0 path.

Cc: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 65c162c..5dcd3f6 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -378,6 +378,8 @@ static int bf5xx_ac97_probe(struct platform_device *pdev,
 		goto sport_config_err;
 	}
 
+	return 0;
+
 sport_config_err:
 	kfree(sport_handle);
 sport_err:
-- 
1.5.6.3
