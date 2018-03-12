From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Fix jack-dectect typo in the
	dt-bindings documentation" to the asoc tree
Date: Mon, 12 Mar 2018 21:17:54 +0000 (GMT)
Message-ID: <20180312211754.D3FFF440079@finisterre.ee.mobilebroadband>
References: <20180312193436.8385-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0316598126240786390=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D67F266F68
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 22:17:59 +0100 (CET)
In-Reply-To: <20180312193436.8385-2-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============0316598126240786390==
Content-Type: text/plain

The patch

   ASoC: rt5651: Fix jack-dectect typo in the dt-bindings documentation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6b2d99247b62d288b5b320fcea46c164ab733e49 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Mar 2018 20:34:36 +0100
Subject: [PATCH] ASoC: rt5651: Fix jack-dectect typo in the dt-bindings
 documentation

Fix the jack-dectect typo in the dt-bindings documentation.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5651.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
index 7890aa9477f8..b85221864cec 100644
--- a/Documentation/devicetree/bindings/sound/rt5651.txt
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -18,9 +18,9 @@ Optional properties:
 
 - realtek,jack-detect-source
   u32. Valid values:
-  1: Use JD1_1 pin for jack-dectect
-  2: Use JD1_2 pin for jack-dectect
-  3: Use JD2 pin for jack-dectect
+  1: Use JD1_1 pin for jack-detect
+  2: Use JD1_2 pin for jack-detect
+  3: Use JD2 pin for jack-detect
 
 - realtek,over-current-threshold-microamp
   u32, micbias over-current detection threshold in µA, valid values are
-- 
2.16.2


--===============0316598126240786390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0316598126240786390==--
