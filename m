From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] snd_tlv_convert_from_dB: fix decreasing gain
	across entries
Date: Mon, 30 Sep 2013 15:25:49 -0600
Message-ID: <1380576349-3695-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B95C6265133
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 23:25:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Currently, for a TLV consisting of TLV_DB_SCALE_ITEMs, if e.g. alsamixer
calls snd_mixer_selem_set_playback_dB() with a value that is in-between
two TLV_DB_SCALE_ITEMs, and xdir is negative, the selected raw hardware
value is the minimum in the first range above that value, rather than the
maximum in the last range below that value.

The user-visible symptom is that in alsamixer, pressing the down key to
reduce the value sticks at certain points, and cannot be incrementally
reduced any further, although directly selecting a much lower value (e.g.
by pressing 0..9) works as expected. This is triggered e.g. by
sound/soc/codec/max98090.c's max98090_hp_tlv[].

Fix this by checking whether xdir is positive or not, rather than
checking whether it has a non-zero value. The code to select the previous
range's max value is already present. This matches how xdir is used in
other parts of the code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 src/control/tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/tlv.c b/src/control/tlv.c
index 6b0b9f4..b08d887 100644
--- a/src/control/tlv.c
+++ b/src/control/tlv.c
@@ -312,7 +312,7 @@ int snd_tlv_convert_from_dB(unsigned int *tlv, long rangemin, long rangemax,
 							       submin, submax,
 							       db_gain, value, xdir);
 			else if (db_gain < dbmin) {
-				*value = xdir || pos == 2 ? submin : prev_submax;
+				*value = xdir > 0 || pos == 2 ? submin : prev_submax;
 				return 0;
 			}
 			prev_submax = submax;
-- 
1.8.1.5
