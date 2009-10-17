From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/14] sound/soc: Move dereference after NULL test
Date: Sat, 17 Oct 2009 08:32:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0910170832300.9213@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751345AbZJQGc4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lin
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

If the NULL test on jack is needed, then the derefernce should be after the
NULL test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/soc-jack.c                |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 1d455ab..1212414 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_new);
  */
 void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 {
-	struct snd_soc_codec *codec = jack->card->codec;
+	struct snd_soc_codec *codec;
 	struct snd_soc_jack_pin *pin;
 	int enable;
 	int oldstatus;
@@ -67,6 +67,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
 		WARN_ON_ONCE(!jack);
 		return;
 	}
+	codec = jack->card->codec;
 
 	mutex_lock(&codec->mutex);
 
