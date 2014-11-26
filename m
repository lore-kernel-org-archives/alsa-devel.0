From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda - using uninitialized data
Date: Thu, 27 Nov 2014 01:34:43 +0300
Message-ID: <20141126223443.GA443@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 993A92612AE
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 23:35:12 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Danny Tholen <obiwan@mailmij.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In olden times the snd_hda_param_read() function always set "*start_id"
but in 2007 we introduced a new return and it causes uninitialized data
bugs in a couple of the callers: print_codec_info() and
hdmi_parse_codec().

Fixes: e8a7f136f5ed ('[ALSA] hda-intel - Improve HD-audio codec probing robustness')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from static analysis.  Untested.

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b2d5899..2fe86d2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -346,8 +346,10 @@ int snd_hda_get_sub_nodes(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int parm;
 
 	parm = snd_hda_param_read(codec, nid, AC_PAR_NODE_COUNT);
-	if (parm == -1)
+	if (parm == -1) {
+		*start_id = 0;
 		return 0;
+	}
 	*start_id = (parm >> 16) & 0x7fff;
 	return (int)(parm & 0x7fff);
 }
