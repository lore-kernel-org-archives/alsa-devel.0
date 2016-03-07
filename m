From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsrc-card: tidyup convert-channels
	explain" to the asoc tree
Date: Mon, 07 Mar 2016 14:43:02 +0700
Message-ID: <E1acpok-00075j-KU@finisterre>
References: <87mvqayjlw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E394265130
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 08:43:05 +0100 (CET)
In-Reply-To: <87mvqayjlw.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsrc-card: tidyup convert-channels explain

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 74e26809fb47e072d0838f74a08a0a5aa428848f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Mar 2016 04:57:55 +0000
Subject: [PATCH] ASoC: rsrc-card: tidyup convert-channels explain

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index 5abebf7898d9..255ece3043ad 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -30,7 +30,7 @@ Optional subnode properties:
 - frame-inversion			: bool property. Add this if the
 					  dai-link uses frame clock inversion.
 - convert-rate				: platform specified sampling rate convert
-- convert-channels			: platform specified channel size convert
+- convert-channels			: platform specified converted channel size (2 - 8 ch)
 - audio-prefix				: see audio-routing
 - audio-routing				: A list of the connections between audio components.
 					  Each entry is a pair of strings, the first being the connection's sink,
-- 
2.7.0
