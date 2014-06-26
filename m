From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/7] ASoC: kirkwood-i2s: fix RECCTL masking
Date: Thu, 26 Jun 2014 15:23:00 +0100
Message-ID: <E1X0AZo-0003iI-7d@rmk-PC.arm.linux.org.uk>
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

Since we wish to disable capture inputs for some formats, we need to
ensure that we clear the enable bits in our cached record control
register.  This seems to have been missed, resulting in the register
only accumulating enable bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 55af6c8e4603..ef1a164d8703 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -212,7 +212,8 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				    KIRKWOOD_PLAYCTL_SIZE_MASK);
 		priv->ctl_play |= ctl_play;
 	} else {
-		priv->ctl_rec &= ~KIRKWOOD_RECCTL_SIZE_MASK;
+		priv->ctl_rec &= ~(KIRKWOOD_RECCTL_ENABLE_MASK |
+				   KIRKWOOD_RECCTL_SIZE_MASK);
 		priv->ctl_rec |= ctl_rec;
 	}
 
-- 
1.8.3.1
