From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: sb_mixer: missing return statement
Date: Wed, 14 May 2014 16:32:21 +0300
Message-ID: <20140514133221.GD14571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The if condition here was supposed to return on error but the return
statement is missing.  The effect is that the ->mixername is set to
"???" instead of "DT019X".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index 6496822..1ff78ec 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -818,12 +818,14 @@ int snd_sbmixer_new(struct snd_sb *chip)
 			return err;
 		break;
 	case SB_HW_DT019X:
-		if ((err = snd_sbmixer_init(chip,
-					    snd_dt019x_controls,
-					    ARRAY_SIZE(snd_dt019x_controls),
-					    snd_dt019x_init_values,
-					    ARRAY_SIZE(snd_dt019x_init_values),
-					    "DT019X")) < 0)
+		err = snd_sbmixer_init(chip,
+				       snd_dt019x_controls,
+				       ARRAY_SIZE(snd_dt019x_controls),
+				       snd_dt019x_init_values,
+				       ARRAY_SIZE(snd_dt019x_init_values),
+				       "DT019X");
+		if (err < 0)
+			return err;
 		break;
 	default:
 		strcpy(card->mixername, "???");
