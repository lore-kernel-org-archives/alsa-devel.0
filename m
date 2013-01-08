From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 107/112] ALSA: hda - Don't set up active
	streams twice
Date: Tue,  8 Jan 2013 12:39:40 +0100
Message-ID: <1357645185-7645-108-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 60780265238
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 13D20A5429
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

We don't have to set up a stream that has been already set up
previously.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index cd318e4..c8cc7ce 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1493,7 +1493,7 @@ void snd_hda_codec_setup_stream(struct hda_codec *codec, hda_nid_t nid,
 		    "NID=0x%x, stream=0x%x, channel=%d, format=0x%x\n",
 		    nid, stream_tag, channel_id, format);
 	p = get_hda_cvt_setup(codec, nid);
-	if (!p)
+	if (!p || p->active)
 		return;
 
 	if (codec->pcm_format_first)
@@ -1540,7 +1540,7 @@ void __snd_hda_codec_cleanup_stream(struct hda_codec *codec, hda_nid_t nid,
 
 	snd_printdd("hda_codec_cleanup_stream: NID=0x%x\n", nid);
 	p = get_hda_cvt_setup(codec, nid);
-	if (p) {
+	if (p && p->active) {
 		/* here we just clear the active flag when do_now isn't set;
 		 * actual clean-ups will be done later in
 		 * purify_inactive_streams() called from snd_hda_codec_prpapre()
-- 
1.8.0.1
