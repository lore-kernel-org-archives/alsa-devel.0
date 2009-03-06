From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 5/5] ASoC: Blackfin: fix typo in MUTE definition
Date: Fri,  6 Mar 2009 15:53:30 +0800
Message-ID: <1236326010-683-6-git-send-email-cooloney@kernel.org>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 33856103885
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 08:51:24 +0100 (CET)
In-Reply-To: <1236326010-683-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Mike Frysinger <vapier.adi@gmail.com>

Reported-by: Rob Maris <maris.rob@vdi.de>
Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/codecs/ad73311.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad73311.h b/sound/soc/codecs/ad73311.h
index 507ce0c..569573d 100644
--- a/sound/soc/codecs/ad73311.h
+++ b/sound/soc/codecs/ad73311.h
@@ -70,7 +70,7 @@
 #define REGD_IGS(x)		(x & 0x7)
 #define REGD_RMOD		(1 << 3)
 #define REGD_OGS(x)		((x & 0x7) << 4)
-#define REGD_MUTE		(x << 7)
+#define REGD_MUTE		(1 << 7)
 
 /* Control register E */
 #define CTRL_REG_E	(4 << 8)
-- 
1.5.6.3
