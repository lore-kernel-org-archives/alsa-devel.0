From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 054/112] ALSA: hda - Allow one chance for zero
	NID in connection list
Date: Tue,  8 Jan 2013 12:38:47 +0100
Message-ID: <1357645185-7645-55-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 00BDE2651D2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1C2ACA52C5
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

The commit [2e9bf24: ALSA: hda_codec: Check for invalid zero
connections] trims the whole connection list when an invalid value is
reported by the hardware.  But some codecs (at least AD1986A) may give
a zero NID in the middle of the connection list, so dropping the whole
list isn't good for such cases.

In this patch, as a workaround, allow a single zero NID in the read
connection list.  If it hits zero twice, it's handled as an error, so
that we can avoid "too many connections" errors.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 12b88a2..650498b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -424,6 +424,7 @@ int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int shift, num_elems, mask;
 	unsigned int wcaps;
 	hda_nid_t prev_nid;
+	int null_count = 0;
 
 	if (snd_BUG_ON(!conn_list || max_conns <= 0))
 		return -EINVAL;
@@ -474,7 +475,7 @@ int snd_hda_get_raw_connections(struct hda_codec *codec, hda_nid_t nid,
 		}
 		range_val = !!(parm & (1 << (shift-1))); /* ranges */
 		val = parm & mask;
-		if (val == 0) {
+		if (val == 0 && null_count++) {  /* no second chance */
 			snd_printk(KERN_WARNING "hda_codec: "
 				   "invalid CONNECT_LIST verb %x[%i]:%x\n",
 				    nid, i, parm);
-- 
1.8.0.1
