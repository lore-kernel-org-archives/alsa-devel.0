From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 6/7] ASoC: kirkwood: allow smaller audio periods and smaller
 number of periods
Date: Thu, 26 Jun 2014 15:23:15 +0100
Message-ID: <E1X0Aa3-0003iU-Hc@rmk-PC.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

There is no hardware restriction requiring a minimum of 8 periods, or
a minimum of 2048 bytes in a period.  Let's drop these values so that
userspace has more flexibility in choosing these parameters.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index ab21de090938..90e32a781424 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -124,9 +124,9 @@
 
 /* Theses values come from the marvell alsa driver */
 /* need to find where they come from               */
-#define KIRKWOOD_SND_MIN_PERIODS		8
+#define KIRKWOOD_SND_MIN_PERIODS		2
 #define KIRKWOOD_SND_MAX_PERIODS		16
-#define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x800
+#define KIRKWOOD_SND_MIN_PERIOD_BYTES		256
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x8000
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
 						 * KIRKWOOD_SND_MAX_PERIODS)
-- 
1.8.3.1
