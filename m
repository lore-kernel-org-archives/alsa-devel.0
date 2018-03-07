From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add devicetree-bindings for
	jack-detect" to the asoc tree
Date: Wed, 07 Mar 2018 14:14:50 +0000
Message-ID: <E1etZqE-0001Um-6P@debutante>
References: <20180304143610.21125-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5320124451221362825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 70578267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:14:55 +0100 (CET)
In-Reply-To: <20180304143610.21125-3-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

--===============5320124451221362825==
Content-Type: text/plain

The patch

   ASoC: rt5651: Add devicetree-bindings for jack-detect

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

>From 9db7d4b32cbccb5807e2e1f22e2fafc80034ee6d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:50 +0100
Subject: [PATCH] ASoC: rt5651: Add devicetree-bindings for jack-detect

Add new properties to the rt5651 dt-bindings for configuring the
jack-detect source and over-current detect settings.

Cc: devicetree@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5651.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
index 3875233095f5..7890aa9477f8 100644
--- a/Documentation/devicetree/bindings/sound/rt5651.txt
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -16,6 +16,23 @@ Optional properties:
 - realtek,dmic-en
   Boolean. true if dmic is used.
 
+- realtek,jack-detect-source
+  u32. Valid values:
+  1: Use JD1_1 pin for jack-dectect
+  2: Use JD1_2 pin for jack-dectect
+  3: Use JD2 pin for jack-dectect
+
+- realtek,over-current-threshold-microamp
+  u32, micbias over-current detection threshold in µA, valid values are
+  600, 1500 and 2000µA.
+
+- realtek,over-current-scale-factor
+  u32, micbias over-current detection scale-factor, valid values are:
+  0: Scale current by 0.5
+  1: Scale current by 0.75
+  2: Scale current by 1.0
+  3: Scale current by 1.5
+
 Pins on the device (for linking into audio routes) for RT5651:
 
   * DMIC L1
-- 
2.16.2


--===============5320124451221362825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5320124451221362825==--
