From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 4/4] ARM: mvebu: fix routing for analog audio input of Armada
 370 DB platform
Date: Wed, 25 Feb 2015 22:58:02 +0100
Message-ID: <1424901482-3809-5-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@free-electrons.com, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, alior@marvell.com, alsa-devel@alsa-project.org, tawfik@marvell.com, jaz@semihalf.com, ezequiel.garcia@free-electrons.com, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Armada 370 DB sound complex comprise routing for audio card with a
description for analog input line with two left channels instead of a pair
left-right. This commit introduces routing for the right channel.

Fixes: a6b334514be2 ("use simple-card DT binding for audio on Armada 370 DB")

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Cc: <stable@vger.kernel.org> # v3.19+
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index e993c46..d6e72a4 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -190,7 +190,7 @@
 			"Out Jack", "HPL",
 			"Out Jack", "HPR",
 			"AIN1L", "In Jack",
-			"AIN1L", "In Jack";
+			"AIN1R", "In Jack";
 		status = "okay";
 
 		simple-audio-card,dai-link@0 {
-- 
1.8.3.1
