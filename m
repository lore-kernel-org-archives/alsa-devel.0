From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] [ALSA] seq_oss_event: missing range checks
Date: Mon, 4 Mar 2013 15:19:18 +0300
Message-ID: <20130304121918.GA587@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEA426508F
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 13:20:50 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The "dev" variable could be out of bounds.  Calling
snd_seq_oss_synth_is_valid() checks that it is is a valid device
which has been opened.  We check this inside set_note_event() so
this function can't succeed without a valid "dev".  But we need to
do the check earlier to prevent invalid dereferences and memory
corruption.

One call tree where "dev" could be out of bounds is:
-> snd_seq_oss_oob_user()
   -> snd_seq_oss_process_event()
      -> extended_event()
         -> note_on_event()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/core/seq/oss/seq_oss_event.c b/sound/core/seq/oss/seq_oss_event.c
index 066f5f3..c390886 100644
--- a/sound/core/seq/oss/seq_oss_event.c
+++ b/sound/core/seq/oss/seq_oss_event.c
@@ -285,7 +285,12 @@ local_event(struct seq_oss_devinfo *dp, union evrec *q, struct snd_seq_event *ev
 static int
 note_on_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, struct snd_seq_event *ev)
 {
-	struct seq_oss_synthinfo *info = &dp->synths[dev];
+	struct seq_oss_synthinfo *info;
+
+	if (!snd_seq_oss_synth_is_valid(dp, dev))
+		return -ENXIO;
+
+	info = &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >= info->nr_voices) {
@@ -340,7 +345,12 @@ note_on_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, st
 static int
 note_off_event(struct seq_oss_devinfo *dp, int dev, int ch, int note, int vel, struct snd_seq_event *ev)
 {
-	struct seq_oss_synthinfo *info = &dp->synths[dev];
+	struct seq_oss_synthinfo *info;
+
+	if (!snd_seq_oss_synth_is_valid(dp, dev))
+		return -ENXIO;
+
+	info = &dp->synths[dev];
 	switch (info->arg.event_passing) {
 	case SNDRV_SEQ_OSS_PROCESS_EVENTS:
 		if (! info->ch || ch < 0 || ch >= info->nr_voices) {
