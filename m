From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opl3sa2: add ZV port control
Date: Tue, 24 Mar 2009 22:37:14 +0100
Message-ID: <20090324223714.c65e9232.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id B8D9924359
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 22:36:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add ZV port control switch.

This patch is done after solution
given in the ALSA bug #2872 report.
The patch resolves the issue.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opl3sa2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index f395b0f..d161e74 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -477,6 +477,7 @@ OPL3SA2_DOUBLE_TLV("Master Playback Volume", 0, 0x07, 0x08, 0, 0, 15, 1,
 OPL3SA2_SINGLE("Mic Playback Switch", 0, 0x09, 7, 1, 1),
 OPL3SA2_SINGLE_TLV("Mic Playback Volume", 0, 0x09, 0, 31, 1,
 		   db_scale_5bit_12db_max),
+OPL3SA2_SINGLE("ZV Port Switch", 0, 0x02, 0, 1, 0),
 };
 
 static struct snd_kcontrol_new snd_opl3sa2_tone_controls[] = {
-- 
1.5.2.2


----------------------------------------------------------------------
Szukasz pieniedzy? Wez podwojny limit zadluzenia w koncie direct.
>> http://link.interia.pl/f20a3
