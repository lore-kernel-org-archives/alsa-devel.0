From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 3/6] ALSA: hda/ca0132: Restore behavior of
	QUIRK_ALIENWARE
Date: Fri, 15 Jun 2018 21:56:17 -0400
Message-ID: <20180616015620.26663-4-alastair.bridgewater@gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit e93ac30a32a6ba7ac3b4b2a4379af1dadb91e505 (ALSA: HDA/ca0132:
add extra init functions for r3di + sbz) introduced an extra
initialization function that was improperly guarded, taking effect
on systems with QUIRK_ALIENWARE, even though such systems were
supposedly not affected.

It may be that this piece of initialization should be done for all
systems, but that's not a call that I can make.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bdd626bde267..ca7375e48138 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7223,7 +7223,7 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_sequence_write(codec, spec->base_init_verbs);
 
-	if (spec->quirk != QUIRK_NONE)
+	if (spec->use_alt_functions)
 		ca0132_alt_init(codec);
 
 	ca0132_download_dsp(codec);
-- 
2.16.1
