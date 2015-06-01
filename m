From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] ASoC: DAPM: fix snd_soc_dapm_new_control()
	implicit declaration
Date: Tue,  2 Jun 2015 00:57:53 +0300
Message-ID: <1433195873-29889-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mleia.com (li271-223.members.linode.com [178.79.152.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 73AE726040E
 for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2015 23:58:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The change fixes the following compilation problem:

  sound/soc/soc-dapm.c: In function 'dapm_kcontrol_data_alloc':
  sound/soc/soc-dapm.c:388:4: error: implicit declaration of function
    'snd_soc_dapm_new_control' [-Werror=implicit-function-declaration]
    data->widget = snd_soc_dapm_new_control(widget->dapm,
    ^

  sound/soc/soc-dapm.c:387:17: warning: assignment makes pointer
    from integer without a cast [enabled by default]
    data->widget = snd_soc_dapm_new_control(widget->dapm,
                 ^
  sound/soc/soc-dapm.c: At top level:
  sound/soc/soc-dapm.c:3269:1: error: conflicting types for
    'snd_soc_dapm_new_control'
  snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
  ^

In addition to the fix add static qualifier to
snd_soc_dapm_new_control() function to silence checkpatch.

Fixes: 02aa78abec ("ASoC: DAPM: Add APIs to create individual DAPM controls.")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 sound/soc/soc-dapm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 78d96e1..0d800ac 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -52,6 +52,11 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	const char *control,
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink));
+
+static struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+			 const struct snd_soc_dapm_widget *widget);
+
 struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget);
@@ -3265,7 +3270,7 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-struct snd_soc_dapm_widget *
+static struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
-- 
2.1.4
