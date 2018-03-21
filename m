From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH RESEND, alsa-lib,
	v2] topology: Fix parsing config with multiple hw_configs
Date: Wed, 21 Mar 2018 20:08:04 +0100
Message-ID: <20180321190804.6168-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F182670F8
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 20:07:51 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id e194so11637149wmd.3
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 12:07:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently, if the config file includes several hw_configs sections,
parse_hw_config_refs() returns after parsing only the first section.

For example, the following config, based on
alsa-lib/src/conf/topology/broadwell/broadwell.conf, is parsed incorrectly:

~~~~
SectionHWConfig."CodecHWConfig" {
        id "1"
        format "I2S"            # physical audio format.
        bclk   "master"         # Platform is master of bit clock
        fsync  "master"         # platform is master of fsync
}

SectionHWConfig."CodecHWConfig2" {
        id "2"
        format "AC97"
}

SectionLink."Codec" {

        # used for binding to the physical link
        id "0"

        hw_configs [
                "CodecHWConfig"
                "CodecHWConfig2"
        ]

        default_hw_conf_id "2"
}
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 src/topology/pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 58cee31d..d3836677 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -882,6 +882,7 @@ static int parse_hw_config_refs(snd_tplg_t *tplg, snd_config_t *cfg,
 	/* refer to a list of HW configs */
 	snd_config_for_each(i, next, cfg) {
 		const char *val;
+		int err;
 
 		n = snd_config_iterator_entry(i);
 		if (snd_config_get_string(n, &val) < 0)
@@ -893,7 +894,9 @@ static int parse_hw_config_refs(snd_tplg_t *tplg, snd_config_t *cfg,
 		}
 
 		link->num_hw_configs++;
-		return tplg_ref_add(elem, SND_TPLG_TYPE_HW_CONFIG, val);
+		err = tplg_ref_add(elem, SND_TPLG_TYPE_HW_CONFIG, val);
+		if (err < 0)
+			return err;
 	}
 
 	return 0;
-- 
2.13.6
