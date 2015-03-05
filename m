From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Thu, 05 Mar 2015 17:52:19 +0100
Message-ID: <54f889c7.33f7fe8f.bm001@wupperonline.de>
References: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 78E7A26052A
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 17:54:43 +0100 (CET)
In-Reply-To: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
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
Cc: superquad.vortex2@gmail.com, tiwai@suse.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote on Fri, 27 Feb 2015 10:11:20 +0800:

> Try [...] to change node 0x15 Speaker as not connected

This is exactly what I did now:

diff -Nur a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c	2015-02-27 02:49:36.000000000 +0100
+++ b/sound/pci/hda/patch_realtek.c	2015-03-05 17:09:15.305016021 +0100
@@ -5665,9 +5665,10 @@

 static int alc662_parse_auto_config(struct hda_codec *codec)
 {
-	static const hda_nid_t alc662_ignore[] = { 0x1d, 0 };
+	/* ignore internal speaker (0x15) in order to get a multi-io config */
+	static const hda_nid_t alc662_ignore[] = { 0x15, 0x1d, 0 };
 	static const hda_nid_t alc663_ssids[] = { 0x15, 0x1b, 0x14, 0x21 };
-	static const hda_nid_t alc662_ssids[] = { 0x15, 0x1b, 0x14, 0 };
+	static const hda_nid_t alc662_ssids[] = { 0x1b, 0x14, 0 };
 	const hda_nid_t *ssids;

 	if (codec->vendor_id == 0x10ec0272 || codec->vendor_id == 0x10ec0663 ||

It gives me the multi-io config without side effects and without the
hp_lo_shared and spk_lo_shared issue in get_line_out_pfx().

I'd like to make this configurable for people suffering from the same problem
with their ALC662, but I don't know how to identify when it would occur.

Ingo
