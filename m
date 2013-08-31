From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 03/14] ASoC: avoid duplicated DAI routes
Date: Sat, 31 Aug 2013 13:37:34 +0100
Message-ID: <E1VFkQo-0003IE-Bw@rmk-PC.arm.linux.org.uk>
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

ASoC automatically creates snd_soc_dapm_dai_in and snd_soc_dapm_dai_out
widgets for DAI drivers, and adds them to the list.  Later on, ASoC
creates automatic routes between these widgets and a widget with a
stream name.

We look for a snd_soc_dapm_dai_in or snd_soc_dapm_dai_out widget, and
use this to obtain the DAI structure.  We then scan all widgets for
any with a stream name refering to either the capture or the playback
stream, and create routes.

If you have both a snd_soc_dapm_dai_in and a snd_soc_dapm_dai_out
referring to the same DAI structure, this ends up creating one set of
routes for the DAI for the snd_soc_dapm_dai_in widget, and a duplicated
set of routes for the snd_soc_dapm_dai_out widget.

Fix this by checking that the stream name for the widget matches the
DAI widget name.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c7051c4..9f67976 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3439,7 +3439,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname)
+			if (!w->sname || !strstr(w->sname, dai_w->name))
 				continue;
 
 			if (dai->driver->playback.stream_name &&
-- 
1.7.4.4
