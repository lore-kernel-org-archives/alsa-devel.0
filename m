From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 1/2] ASoC: sti: set iec958 channel status
	sampling freq
Date: Tue, 24 Nov 2015 14:16:35 +0100
Message-ID: <1448370996-30224-2-git-send-email-moise.gergaud@st.com>
References: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FFB0265DAB
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 14:16:50 +0100 (CET)
In-Reply-To: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Previously, the iec958 channels status sampling freq was set only if not
already set. It means that it is not updated for next PCM sessions.
With this patch, we ensure the iec958 channels status sampling freq is set
to the runtime rate for each PCM session.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 5c2bc53..7aca6b9 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -251,8 +251,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * set one.
 	 */
 	mutex_lock(&player->ctrl_lock);
-	if (runtime && (player->stream_settings.iec958.status[3]
-					== IEC958_AES3_CON_FS_NOTID)) {
+	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
 			player->stream_settings.iec958.status[3] =
-- 
1.9.1
