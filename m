From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: usb-audio: Fix potential
	zero-division at parsing FU
Date: Tue, 21 Nov 2017 17:33:53 +0100
Message-ID: <20171121163354.2665-4-tiwai@suse.de>
References: <20171121163354.2665-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A469266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 17:33:58 +0100 (CET)
In-Reply-To: <20171121163354.2665-1-tiwai@suse.de>
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
Cc: Andrey Konovalov <andreyknvl@google.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: alsa-devel@alsa-project.org

parse_audio_feature_unit() contains a code dividing potentially with
zero when a malformed FU descriptor is passed.  Although there is
already a sanity check, it checks only the value zero, hence it can
still lead to a zero-division when a value 1 is passed there.

Fix it by correcting the sanity check (and the error message
thereof).

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 61b348383de8..0537c6322990 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1476,9 +1476,9 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
 			return -EINVAL;
 		}
 		csize = hdr->bControlSize;
-		if (!csize) {
+		if (csize <= 1) {
 			usb_audio_dbg(state->chip,
-				      "unit %u: invalid bControlSize == 0\n",
+				      "unit %u: invalid bControlSize <= 1\n",
 				      unitid);
 			return -EINVAL;
 		}
-- 
2.15.0
