From: Mark Brown <broonie@kernel.org>
Subject: Applied "- filename :
	ASoC-rsnd-audio_clkout0-1-2-3-are-optinal-properties.patch
Date: Fri, 30 Oct 2015 10:43:24 +0900
Message-ID: <E1Zryiy-0008TV-4A@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5259D265CC8
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 02:43:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

- name          : ASoC: rsnd: audio_clkout0/1/2/3 are optinal properties" to the asoc tree
In-Reply-To:  <871tce16oa.wl%kuninori.morimoto.gx@renesas.com>

The patch

   - filename      : ASoC-rsnd-audio_clkout0-1-2-3-are-optinal-properties.patch
- name          : ASoC: rsnd: audio_clkout0/1/2/3 are optinal properties

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

>From 61af9ed7475090b79e9305a4c52c9d3adb2d1784 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Oct 2015 07:42:40 +0000
Subject: [PATCH] ASoC: rsnd: audio_clkout0/1/2/3 are optional properties

Renesas sound driver can output Audio-clkout0/1/2/3,
but these are optional properties for each board.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index c57cbd6..bbcb327 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -34,6 +34,8 @@ Required properties:
 				  see below for detail.
 - #sound-dai-cells		: it must be 0 if your system is using single DAI
 				  it must be 1 if your system is using multi  DAI
+
+Optional properties:
 - #clock-cells			: it must be 0 if your system has audio_clkout
 				  it must be 1 if your system has audio_clkout0/1/2/3
 - clock-frequency		: for all audio_clkout0/1/2/3
-- 
2.6.1
