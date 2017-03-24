From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: STI: Fix reader substream pointer set"
	to the asoc tree
Date: Fri, 24 Mar 2017 19:16:37 +0000
Message-ID: <E1crUhR-00067q-46@debutante>
References: <1490294395-13416-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7690E267572
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:16:50 +0100 (CET)
In-Reply-To: <1490294395-13416-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: STI: Fix reader substream pointer set

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

>From 3c9d3f1bc2defd418b5933bbc928096c9c686d3b Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 23 Mar 2017 19:39:54 +0100
Subject: [PATCH] ASoC: STI: Fix reader substream pointer set

reader->substream is used in IRQ handler for error case but is never set.
Set value to pcm substream on DAI startup and clean it on dai shutdown.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_reader.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 5992c6ab3833..93a8df6ed880 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -349,6 +349,8 @@ static int uni_reader_startup(struct snd_pcm_substream *substream,
 	struct uniperif *reader = priv->dai_data.uni;
 	int ret;
 
+	reader->substream = substream;
+
 	if (!UNIPERIF_TYPE_IS_TDM(reader))
 		return 0;
 
@@ -378,6 +380,7 @@ static void uni_reader_shutdown(struct snd_pcm_substream *substream,
 		/* Stop the reader */
 		uni_reader_stop(reader);
 	}
+	reader->substream = NULL;
 }
 
 static const struct snd_soc_dai_ops uni_reader_dai_ops = {
-- 
2.11.0
