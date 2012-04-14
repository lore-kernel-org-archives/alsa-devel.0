From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 1/2] snd-usb-audio: Skip un-parseable mixer
	units instead of erroring
Date: Sat, 14 Apr 2012 17:19:23 +0100
Message-ID: <1334420364-30700-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DEAD246CC
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Apr 2012 18:19:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some interfaces reference endpoints which do not exists. To
accomodate these, do not fail completely, but skip over them.

This allows the Electrix Ebox-44 with earlier firmware to be
detected and used for audio.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/mixer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ab23869..c374c72 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1388,7 +1388,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid, void *r
 	for (pin = 0; pin < input_pins; pin++) {
 		err = parse_audio_unit(state, desc->baSourceID[pin]);
 		if (err < 0)
-			return err;
+			continue;
 		err = check_input_term(state, desc->baSourceID[pin], &iterm);
 		if (err < 0)
 			return err;
-- 
1.7.4.4
