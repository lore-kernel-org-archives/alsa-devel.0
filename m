From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: fix channel status update after
	playback start" to the asoc tree
Date: Wed, 26 Oct 2016 11:46:03 +0100
Message-ID: <E1bzLid-0005MY-Iq@debutante>
References: <1477320177-30130-3-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9DB266FBB
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:10 +0200 (CEST)
In-Reply-To: <1477320177-30130-3-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: fix channel status update after playback start

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1e6d304431958929b601b013687b73293ba27b88 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:52 +0200
Subject: [PATCH] ASoC: sti: fix channel status update after playback start

If 'IEC958 Playback Default' control is updated during playback,
Channel status needs to be set according to the runtime structure.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 1bc8ebc2528e..ad54d4cf58ad 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -614,7 +614,11 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
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
2.8.1
