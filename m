From: Jerone Young <jerone.young@canonical.com>
Subject: [PATCH] FIX to not expose SPDIF on Thinkpad X301,
 since it does not have the ability to use SPDIF
Date: Mon, 02 Aug 2010 22:04:13 -0500
Message-ID: <1280804653.1832.17.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 12E9F10382E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 05:04:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The Lenovo X301 does not have the ability to connect to a docking
station to use the SPDIF port. It also does not have the ability to do
SPDIF though the headphone jack or Display Port jacks.

This patch fixes it so this is not exposed for the X301 and users do
think it has the ability to do SPDIF.

I tested both headphone & display port jacks and it is not there. I have
tested this patch and it works great.

Also to add the other Thinkpads have different subsystem codec IDs. 
Here are examples:

X301:
http://launchpadlibrarian.net/31561902/Card0.Codecs.codec.0.txt

X200:
http://launchpadlibrarian.net/49055036/Card0.Codecs.codec.0.txt

W500:
http://launchpadlibrarian.net/36276057/Card0.Codecs.codec.0.txt


Signed-off-by: Jerone Young <jerone.young@canonical.com>

@@ -2004,6 +2006,11 @@ static int patch_cxt5051(struct hda_codec *codec)
 		break;
 	case CXT5051_LENOVO_X200:
 		spec->init_verbs[0] = cxt5051_lenovo_x200_init_verbs;
+		/* Thinkpad X301 does not have S/PDIF wired and no ability
+		   to use a docking station. */
+		if (codec->subsystem_id == 0x17aa211f) {
+			spec->multiout.dig_out_nid = 0; 
+		}
 		break;
 	case CXT5051_F700:
 		spec->init_verbs[0] = cxt5051_f700_init_verbs;
