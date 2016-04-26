From: vedang.patel@intel.com
Subject: [PATCH v2 1/3] ASoC: hdac_hdmi: Increase loglevel of
	hex dump printed
Date: Tue, 26 Apr 2016 16:03:08 -0700
Message-ID: <1461711790-7277-2-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
 <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F796264F22
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 01:03:23 +0200 (CEST)
In-Reply-To: <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
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

Change-Id: I6a7ac1d40a73369ea5dc58b7afde0288b8e86558
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index aaa038f..def565d 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1066,8 +1066,9 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
 			}
 
-			print_hex_dump_bytes("ELD: ", DUMP_PREFIX_OFFSET,
-					pin->eld.eld_buffer, pin->eld.eld_size);
+			print_hex_dump_debug("ELD: ",
+					DUMP_PREFIX_OFFSET, 16, 1,
+					pin->eld.eld_buffer, pin->eld.eld_size, true);
 		} else {
 			pin->eld.monitor_present = false;
 			pin->eld.eld_valid = false;
-- 
2.1.2
