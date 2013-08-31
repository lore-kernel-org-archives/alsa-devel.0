From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/14] ASoC: kirkwood: move calculation of max buffer size to
 kirkwood.h
Date: Sat, 31 Aug 2013 13:40:35 +0100
Message-ID: <E1VFkTj-0003Ic-Kg@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    2 +-
 sound/soc/kirkwood/kirkwood.h     |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 2091d55..ee31016 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -51,7 +51,7 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 	.rate_max		= 384000,
 	.channels_min		= 1,
 	.channels_max		= 8,
-	.buffer_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES * KIRKWOOD_SND_MAX_PERIODS,
+	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
 	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
 	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
 	.periods_min		= KIRKWOOD_SND_MIN_PERIODS,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 1d13dee..f8e1ccc 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -125,6 +125,8 @@
 #define KIRKWOOD_SND_MAX_PERIODS		16
 #define KIRKWOOD_SND_MIN_PERIOD_BYTES		0x4000
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x4000
+#define KIRKWOOD_SND_MAX_BUFFER_BYTES		(KIRKWOOD_SND_MAX_PERIOD_BYTES \
+						 * KIRKWOOD_SND_MAX_PERIODS)
 
 struct kirkwood_dma_data {
 	void __iomem *io;
-- 
1.7.4.4
