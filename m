From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH2/4] hda: dynamic jack id
Date: Sat, 25 Oct 2008 01:05:29 -0400
Message-ID: <4902A919.6010100@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id CB9B824385
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 07:05:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This patch duplicates the jack->id pointer with kstrdup() to prevent
scoping issues from calling autoprobing functions from the HDA section.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 4978db1..284432f 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -34,6 +34,7 @@ static int snd_jack_dev_free(struct snd_device *device)
 	else
 		input_free_device(jack->input_dev);

+	kfree(jack->id);
 	kfree(jack);

 	return 0;
@@ -87,7 +88,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (jack == NULL)
 		return -ENOMEM;

-	jack->id = id;
+	jack->id = kstrdup(id, GFP_KERNEL);

 	jack->input_dev = input_allocate_device();
 	if (jack->input_dev == NULL) {
