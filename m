From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 100/112] ALSA: hda - Allow jack detection when
	polling is enabled
Date: Tue,  8 Jan 2013 12:39:33 +0100
Message-ID: <1357645185-7645-101-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DCB8265230
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 01CFEA5399
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

Let is_jack_detectable() return true when the jack polling is enabled
for the codec.  VT1708 uses the polling explicitly so we need to allow
it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_jack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 6479b65..1d035ef 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -29,7 +29,8 @@ bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 	if (get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)) &
 	     AC_DEFCFG_MISC_NO_PRESENCE)
 		return false;
-	if (!(get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP))
+	if (!(get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) &&
+	    !codec->jackpoll_interval)
 		return false;
 	return true;
 }
-- 
1.8.0.1
