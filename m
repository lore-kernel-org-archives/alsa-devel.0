From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 09/14] ASoC: kirkwood-dma: remove IEC958_SUBFRAME formats
Date: Sat, 31 Aug 2013 13:43:36 +0100
Message-ID: <E1VFkWe-0003Iw-UI@rmk-PC.arm.linux.org.uk>
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

The Audio block does not support IEC958 subframes as formatted by
ALSA: they're very close, but not close enough.  The formats differ
by:

3  2   2   2   1   1
1  8   4   0   6   2   8   4   0
PCUVDDDDDDDDDDDDDDDD....AAAATTTT - IEC958 subframe
PCUV0000........DDDDDDDDDDDDDDDD - Audio block format

Where P = parity, C = channel status, U = user data, V = validity,
D = sample data, A = aux, T = preamble.  As can be seen, the
position of the sample is in a different position, and the audio
block does not have the aux or preamble bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index ee31016..3c8fc75 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -29,9 +29,7 @@
 #define KIRKWOOD_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
-	 SNDRV_PCM_FMTBIT_S32_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE | \
-	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE)
+	 SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 {
-- 
1.7.4.4
