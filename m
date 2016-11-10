From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm2200: Correct types of mixer texts
	and values" to the asoc tree
Date: Thu, 10 Nov 2016 17:29:21 +0000
Message-ID: <E1c4tA9-00060F-Um@finisterre>
References: <1478792092-5990-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E26D126686A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 18:29:35 +0100 (CET)
In-Reply-To: <1478792092-5990-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm2200: Correct types of mixer texts and values

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

>From 4090d63b49d7d440ff984db3715d5c780209e8e8 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 10 Nov 2016 15:34:52 +0000
Subject: [PATCH] ASoC: wm2200: Correct types of mixer texts and values

The core expects "const char * const" and "unsigned int" for enum
controls, the mixer control definitions in wm2200 use "const char *"
and "int".  This patch corrects the type of these arrays.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm2200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 606bf88abfc4..d83dab57a1d1 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -999,7 +999,7 @@ static DECLARE_TLV_DB_SCALE(in_tlv, -6300, 100, 0);
 static DECLARE_TLV_DB_SCALE(digital_tlv, -6400, 50, 0);
 static DECLARE_TLV_DB_SCALE(out_tlv, -6400, 100, 0);
 
-static const char *wm2200_mixer_texts[] = {
+static const char * const wm2200_mixer_texts[] = {
 	"None",
 	"Tone Generator",
 	"AEC Loopback",
@@ -1033,7 +1033,7 @@ static const char *wm2200_mixer_texts[] = {
 	"DSP2.6",
 };
 
-static int wm2200_mixer_values[] = {
+static unsigned int wm2200_mixer_values[] = {
 	0x00,
 	0x04,   /* Tone */
 	0x08,   /* AEC */
-- 
2.10.2
