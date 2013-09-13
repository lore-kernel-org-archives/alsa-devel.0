From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: 88pm860x: array overflow in snd_soc_put_volsw_2r_st()
Date: Fri, 13 Sep 2013 10:52:49 +0300
Message-ID: <20130913075248.GC19211@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Bill Pemberton <wfp5p@virginia.edu>, Lars-Peter Clausen <lars@metafoo.de>, Sachin Kamat <sachin.kamat@linaro.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is called from snd_ctl_elem_write() with user supplied data so we
need to add some bounds checking.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 8af0434..259d1ac 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -349,6 +349,9 @@ static int snd_soc_put_volsw_2r_st(struct snd_kcontrol *kcontrol,
 	val = ucontrol->value.integer.value[0];
 	val2 = ucontrol->value.integer.value[1];
 
+	if (val >= ARRAY_SIZE(st_table) || val2 >= ARRAY_SIZE(st_table))
+		return -EINVAL;
+
 	err = snd_soc_update_bits(codec, reg, 0x3f, st_table[val].m);
 	if (err < 0)
 		return err;
