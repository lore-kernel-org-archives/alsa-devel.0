From: vedang.patel@intel.com
Subject: [PATCH v3 1/3] ASoC: hdac_hdmi: Increase loglevel of
	hex dump printed
Date: Tue, 31 May 2016 18:14:59 -0700
Message-ID: <1464743701-14931-2-git-send-email-vedang.patel@intel.com>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
 <1464743701-14931-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEFC26523B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 03:15:06 +0200 (CEST)
In-Reply-To: <1464743701-14931-1-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

The hdac_hdmi codec driver prints the ELD information everytime an
external monitor is connected. Make it so that the information is only
printed when someone trying to debug the driver explicitly enables it.

print_hex_dump_bytes (which just calls print_hex_dump) uses
printk(KERN_DEBUG,... which is different from dev_dbg used elsewhere in
the driver: it's always enabled at compile-time. Change it to
print_hex_dump_debug for logging consistency.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 181cd3b..62d2181 100644
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
1.7.9.5
