From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Check pincap while parsing the
	configuration
Date: Tue, 15 Jan 2013 12:07:33 +0100
Message-ID: <1358248053-14110-3-git-send-email-tiwai@suse.de>
References: <1358248053-14110-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A7916265CBA
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:07:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8B4B8A5207
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:07:34 +0100 (CET)
In-Reply-To: <1358248053-14110-1-git-send-email-tiwai@suse.de>
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

Sometimes (or rather often) BIOS sets the pin default configurations
obviously wrongly.  Looking through these failures, one common pattern
is to enable some dead pins that are usually marked as speaker pins.
In such a case, we can skip them if the pins don't have the output
capability.

In this patch, add a check for the valid pin cap bit for each parsed
pin, and filter out when it's invalid.

The fix was originally suggested by Raymond Yau.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 33b3ece..a4810c7 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -97,6 +97,28 @@ static void reorder_outputs(unsigned int nums, hda_nid_t *pins)
 	}
 }
 
+/* check whether the given pin has a proper pin I/O capability bit */
+static bool check_pincap_validity(struct hda_codec *codec, hda_nid_t pin,
+				  unsigned int dev)
+{
+	unsigned int pincap = snd_hda_query_pin_caps(codec, pin);
+
+	/* some old hardware don't return the proper pincaps */
+	if (!pincap)
+		return true;
+
+	switch (dev) {
+	case AC_JACK_LINE_OUT:
+	case AC_JACK_SPEAKER:
+	case AC_JACK_HP_OUT:
+	case AC_JACK_SPDIF_OUT:
+	case AC_JACK_DIG_OTHER_OUT:
+		return !!(pincap & AC_PINCAP_OUT);
+	default:
+		return !!(pincap & AC_PINCAP_IN);
+	}
+}
+
 /*
  * Parse all pin widgets and store the useful pin nids to cfg
  *
@@ -164,6 +186,9 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 				dev = AC_JACK_SPEAKER;
 		}
 
+		if (!check_pincap_validity(codec, nid, dev))
+			continue;
+
 		switch (dev) {
 		case AC_JACK_LINE_OUT:
 			seq = get_defcfg_sequence(def_conf);
-- 
1.8.1
