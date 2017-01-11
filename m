From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: seq: Constify snd_rawmidi_ops
Date: Wed, 11 Jan 2017 20:02:37 +0100
Message-ID: <20170111190242.12585-3-tiwai@suse.de>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5733F26753A
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 20:02:44 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CCAEEAC20
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2017 19:02:43 +0000 (UTC)
In-Reply-To: <20170111190242.12585-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Now snd_rawmidi_ops is maintained as a const pointer in snd_rawmidi,
we can constify the definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_virmidi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index c82ed3e70506..52f31f1498f9 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -349,13 +349,13 @@ static int snd_virmidi_unuse(void *private_data,
  *  Register functions
  */
 
-static struct snd_rawmidi_ops snd_virmidi_input_ops = {
+static const struct snd_rawmidi_ops snd_virmidi_input_ops = {
 	.open = snd_virmidi_input_open,
 	.close = snd_virmidi_input_close,
 	.trigger = snd_virmidi_input_trigger,
 };
 
-static struct snd_rawmidi_ops snd_virmidi_output_ops = {
+static const struct snd_rawmidi_ops snd_virmidi_output_ops = {
 	.open = snd_virmidi_output_open,
 	.close = snd_virmidi_output_close,
 	.trigger = snd_virmidi_output_trigger,
-- 
2.11.0
