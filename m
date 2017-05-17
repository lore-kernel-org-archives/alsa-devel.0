From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsi: Move inline fsi_stream_is_play() before use" to the asoc tree
Date: Wed, 17 May 2017 10:51:43 +0100
Message-ID: <E1dAvcN-0006iH-2K@debutante>
References: <1494955200-1051-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494955200-1051-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsi: Move inline fsi_stream_is_play() before use

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

>From 3048e76c93bccf875a49025870de08aed86c4692 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 May 2017 19:20:00 +0200
Subject: [PATCH] ASoC: fsi: Move inline fsi_stream_is_play() before use
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc 4.1.2:

    sound/soc/sh/fsi.c:304: warning: ‘fsi_stream_is_play’ declared inline after being called
    sound/soc/sh/fsi.c:304: warning: previous declaration of ‘fsi_stream_is_play’ was here

Move fsi_stream_is_play() up to fix this, removing the need for a
forward declaration as well.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/fsi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index ead520182e26..7c4bdd82bb95 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -301,7 +301,12 @@ struct fsi_master {
 	spinlock_t lock;
 };
 
-static int fsi_stream_is_play(struct fsi_priv *fsi, struct fsi_stream *io);
+static inline int fsi_stream_is_play(struct fsi_priv *fsi,
+				     struct fsi_stream *io)
+{
+	return &fsi->playback == io;
+}
+
 
 /*
  *		basic read write function
@@ -489,12 +494,6 @@ static void fsi_count_fifo_err(struct fsi_priv *fsi)
 /*
  *		fsi_stream_xx() function
  */
-static inline int fsi_stream_is_play(struct fsi_priv *fsi,
-				     struct fsi_stream *io)
-{
-	return &fsi->playback == io;
-}
-
 static inline struct fsi_stream *fsi_stream_get(struct fsi_priv *fsi,
 					struct snd_pcm_substream *substream)
 {
-- 
2.11.0
