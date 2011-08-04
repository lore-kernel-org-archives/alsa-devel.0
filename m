From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/3] ALSA: snd-usb: avoid dividing by zero on
	invalid input
Date: Thu,  4 Aug 2011 15:56:27 +0200
Message-ID: <1312466188-3428-3-git-send-email-zonque@gmail.com>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 011C924417
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 15:56:57 +0200 (CEST)
In-Reply-To: <1312466188-3428-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Nicolai Krakowiak <nicolai.krakowiak@gmail.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>

Signed-off-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
Acked-by: Daniel Mack <zonque@gmail.com>
Cc: stable@kernel.org
---
 sound/usb/mixer.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index d33a5a9..5ab345f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1191,6 +1191,11 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
 		csize = hdr->bControlSize;
+		if (!csize) {
+			snd_printdd(KERN_ERR "usbaudio: unit %u: "
+				    "invalid bControlSize == 0\n", unitid);
+			return -EINVAL;
+		}
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
 	} else {
-- 
1.7.5.4
