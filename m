From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 2/2] MAINTAINERS: document ASoC header files
Date: Tue, 23 Aug 2016 10:52:47 +0200
Message-ID: <20160823085247.6158-1-nicolas.iooss_linux@m4x.org>
References: <20160823085122.5859-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
 by alsa0.perex.cz (Postfix) with ESMTP id C7163266C5F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 10:53:08 +0200 (CEST)
In-Reply-To: <20160823085122.5859-1-nicolas.iooss_linux@m4x.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

include/sound/simple_card_utils.h is handled by ASoC maintainers, as
stated in https://lkml.org/lkml/2016/8/22/307, and
include/sound/simple_card.h seems to be an ASoC file too.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b105c34..c840582d1439 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11012,6 +11012,8 @@ S:	Supported
 F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/alsa/soc/
 F:	sound/soc/
+F:	include/sound/simple_card.h
+F:	include/sound/simple_card_utils.h
 F:	include/sound/soc*
 
 SOUND - DMAENGINE HELPERS
-- 
2.9.3
