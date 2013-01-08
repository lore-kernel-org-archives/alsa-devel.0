From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 111/112] ALSA: hda - Handle BOTH jack port as a
	fixed output
Date: Tue,  8 Jan 2013 12:39:44 +0100
Message-ID: <1357645185-7645-112-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3F826523C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1800DA543A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When the default config value shows the connection AC_JACK_PORT_BOTH,
it's better to handle it as a speaker pin.  This makes the behavior
consistent in snd_hda_get_pin_label() and snd_hda_parse_pin_defcfg().

There are only few old machines showing this attribute, and all of
them are actually fixed speaker pins, as far as I know.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 44c81d3..6a01c01 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -156,7 +156,8 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 
 		/* workaround for buggy BIOS setups */
 		if (dev == AC_JACK_LINE_OUT) {
-			if (conn == AC_JACK_PORT_FIXED)
+			if (conn == AC_JACK_PORT_FIXED ||
+			    conn == AC_JACK_PORT_BOTH)
 				dev = AC_JACK_SPEAKER;
 		}
 
-- 
1.8.0.1
