From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/1] ASoC: da7213: Correct units description of
	dmic-clkrate
Date: Thu, 8 Oct 2015 11:21:54 +0100
Message-ID: <dbcafb5ad02a756d93458e3262cf1d1eab8f607e.1444299436.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 48B772606D4
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 12:22:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Description previously stated MHz whereas the resolution is in Hz.
This has now has been updated to align with reality.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

This patch is based on changes introduced under patch:

'ASoC: da7213: Add bindings documentation for codec driver'
(Commit a97d4e93a9bc556d0b3c2efb7695eb4c79938de7, kernel/git/broonie/sound.git)

 Documentation/devicetree/bindings/sound/da7213.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
index 7280e82..5890280 100644
--- a/Documentation/devicetree/bindings/sound/da7213.txt
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -18,7 +18,7 @@ Optional properties:
 	["lrise_rfall", "lfall_rrise"]
 - dlg,dmic-samplephase : When to sample audio from DMIC.
 	["on_clkedge", "between_clkedge"]
-- dlg,dmic-clkrate : DMIC clock frequency (MHz).
+- dlg,dmic-clkrate : DMIC clock frequency (Hz).
 	[<1500000>, <3000000>]
 
 ======
-- 
1.9.3
