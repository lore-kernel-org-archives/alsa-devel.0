From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: [PATCH] correct a oops in snd-azx if model=allout
Date: Wed, 05 Jan 2005 09:00:37 +0100
Message-ID: <41DB9EA5.8090504@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from postfix4-2.free.fr (postfix4-2.free.fr [213.228.0.176])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 23ADE2D4
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 09:00:40 +0100 (MET)
Received: from localhost.localdomain (robinson-3-82-66-38-107.fbx.proxad.net [82.66.38.107])
	by postfix4-2.free.fr (Postfix) with ESMTP id 3F70A2A0012
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 09:00:39 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.34)
	id 1Cm65u-00029D-Im
	for alsa-devel@alsa-project.org; Wed, 05 Jan 2005 09:00:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Correct the handling of an array terminated by {}; (introduce in CVS 
version 1.6 of file hda_codec.c)

Nicolas GRAZIANO





Index: pci/azx/hda_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azx/hda_codec.c,v
retrieving revision 1.8
diff -u -r1.8 hda_codec.c
--- pci/azx/hda_codec.c 4 Jan 2005 11:06:19 -0000       1.8
+++ pci/azx/hda_codec.c 5 Jan 2005 07:46:06 -0000
@@ -878,11 +878,15 @@
  */
 int snd_hda_create_spdif_out_ctls(struct hda_codec *codec, hda_nid_t nid)
 {
-       int i, err;
+       int  err;
+
        snd_kcontrol_t *kctl;
-
-       for (i = 0; i < ARRAY_SIZE(dig_mixes); i++) {
-               kctl = snd_ctl_new1(&dig_mixes[i], codec);
+
+       snd_kcontrol_new_t * dig_mix;
+       dig_mix=dig_mixes;
+
+       for (; dig_mix->name; dig_mix++) {
+               kctl = snd_ctl_new1(dig_mix, codec);
                kctl->private_value = nid;
                if ((err = snd_ctl_add(codec->bus->card, kctl)) < 0)
                        return err;




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
