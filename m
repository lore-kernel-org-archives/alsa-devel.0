From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: mfld: Make static string arrays
	'const 'char * const []'" to the asoc tree
Date: Fri, 18 Nov 2016 12:01:49 +0000
Message-ID: <E1c7hrZ-0005Gp-2v@debutante>
References: <1479242445-12069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACDAC266DC0
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 13:02:05 +0100 (CET)
In-Reply-To: <1479242445-12069-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: mfld: Make static string arrays 'const 'char * const []'

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

>From 266c618d67dd4a42f798baaab47634018cb1db4b Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 15 Nov 2016 21:40:45 +0100
Subject: [PATCH] ASoC: intel: mfld: Make static string arrays 'const 'char *
 const []'

const char * const [] is the preferred type for static string arrays since
this states explicitly that the individual entries are not going to be
changed. Due to limitations in the ASoC API it was not possible to use it
for enum text arrays. Commit 87023ff74b23 ("ASoC: Declare const properly
for enum texts") changed this, but most drivers still use 'const char
* []' as the type for their enum text arrays.

Change these occurrences of 'static * const char * []' to 'static const
char * const []'.

The conversion was done automatically using the following coccinelle
semantic patch:
// <smpl>
@disable optional_qualifier@
identifier s;
@@
 static
-const char *
+const char * const
 s[] = ...;
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/mfld_machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 34f46c72a0e2..4e08885f37aa 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -81,9 +81,9 @@ static struct snd_soc_jack_zone mfld_zones[] = {
 };
 
 /* sound card controls */
-static const char *headset_switch_text[] = {"Earpiece", "Headset"};
+static const char * const headset_switch_text[] = {"Earpiece", "Headset"};
 
-static const char *lo_text[] = {"Vibra", "Headset", "IHF", "None"};
+static const char * const lo_text[] = {"Vibra", "Headset", "IHF", "None"};
 
 static const struct soc_enum headset_enum =
 	SOC_ENUM_SINGLE_EXT(2, headset_switch_text);
-- 
2.10.2
