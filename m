From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Increase loglevel of hex
	dump printed" to the asoc tree
Date: Mon, 27 Jun 2016 17:40:27 +0100
Message-ID: <E1bHZaF-0005EU-99@debutante>
References: <1464743701-14931-2-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C9C4266E7C
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 18:40:32 +0200 (CEST)
In-Reply-To: <1464743701-14931-2-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, marc.herbert@intel.com, Mark Brown <broonie@kernel.org>, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Increase loglevel of hex dump printed

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

>From 3cb7cec14415ff8544ae702f396f913cd9008e7e Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Fri, 24 Jun 2016 17:37:09 -0700
Subject: [PATCH] ASoC: hdac_hdmi: Increase loglevel of hex dump printed

The hdac_hdmi codec driver prints the ELD information everytime an
external monitor is connected. Make it so that the information is only
printed when someone trying to debug the driver explicitly enables it.

print_hex_dump_bytes (which just calls print_hex_dump) uses
printk(KERN_DEBUG,... which is different from dev_dbg used elsewhere in
the driver: it's always enabled at compile-time. Change it to
print_hex_dump_debug for logging consistency.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 181cd3bf0b92..62d21812b9b8 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1124,8 +1124,10 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 			}
 			hdac_hdmi_parse_eld(edev, pin);
 
-			print_hex_dump_bytes("ELD: ", DUMP_PREFIX_OFFSET,
-					pin->eld.eld_buffer, pin->eld.eld_size);
+			print_hex_dump_debug("ELD: ",
+					DUMP_PREFIX_OFFSET, 16, 1,
+					pin->eld.eld_buffer, pin->eld.eld_size,
+					true);
 		} else {
 			pin->eld.monitor_present = false;
 			pin->eld.eld_valid = false;
-- 
2.8.1
