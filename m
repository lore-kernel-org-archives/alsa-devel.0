From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 2/7] ASoC: sti: fix channel status update after
	playback start
Date: Mon, 24 Oct 2016 16:42:52 +0200
Message-ID: <1477320177-30130-3-git-send-email-arnaud.pouliquen@st.com>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D8CEE266CAE
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:14 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

If 'IEC958 Playback Default' control is updated during playback,
Channel status needs to be set according to the runtime structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index c9b4670..00a0fb3 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -617,7 +617,11 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	iec958->status[3] = ucontrol->value.iec958.status[3];
 	mutex_unlock(&player->ctrl_lock);
 
-	uni_player_set_channel_status(player, NULL);
+	if (player->substream && player->substream->runtime)
+		uni_player_set_channel_status(player,
+					      player->substream->runtime);
+	else
+		uni_player_set_channel_status(player, NULL);
 
 	return 0;
 }
-- 
1.9.1
