From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] speaker-test: Fix chmap wav file selection.
Date: Wed, 7 Dec 2016 17:44:26 +0100
Message-ID: <1481129066-15961-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6E757267234
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 17:45:13 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, broonie@kernel.org, Anssi Hannula <anssi.hannula@iki.fi>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

The channel selection currently does not work properly when a channel
map control is provided but no manual channel map was explicitly
requested with "-m".

For example, the CEA/HDMI 6ch (surround 5.1) map is:
 FL, FR, LFE, FC, RL, RR.

Tested command: speaker-test -D hdmi -c 6 -t wav

Speaker-test tries to play channels in this following order:
 0 - Front Left
 3 - Front Center
 1 - Front Right
 5 - Rear Right
 4 - Rear Left
 2 - LFE

But wav file played on associated speakers are not aligned. Here are
the real files played:
 0- /usr/share/sounds/alsa/Front_Left.wav => OK
 3- /usr/share/sounds/alsa/Rear_Right.wav  => OK
 1- /usr/share/sounds/alsa/Front_Right.wav  => OK
 5- /usr/share/sounds/alsa/Rear_Center.wav => KO
 4- found file /usr/share/sounds/alsa/Front_Center.wav => KO
 2- /usr/share/sounds/alsa/Rear_Left.wav  => KO

Issue is that associated wav files ordering is reworked only if
channel_map_set variable is set.

Fix consists in allowing wavs re-ordering if a channel mapping as been
get or set, i.e. channel_map is not null.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 speaker-test/speaker-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 5b9cbec..46b0589 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -843,7 +843,7 @@ static int setup_wav_file(int chn)
     return check_wav_file(chn, given_test_wav_file);
 
 #ifdef CONFIG_SUPPORT_CHMAP
-  if (channel_map_set && chn < channel_map->channels) {
+  if (channel_map && chn < channel_map->channels) {
     int channel = channel_map->pos[chn] - SND_CHMAP_FL;
     if (channel >= 0 && channel < MAX_CHANNELS)
       return check_wav_file(chn, wavs[channel]);
-- 
1.9.1
