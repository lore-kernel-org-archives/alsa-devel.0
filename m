From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH utils] aplay: fix VU meter for S24_LE etc
	formats
Date: Tue, 15 Sep 2015 13:10:00 +0200
Message-ID: <alpine.DEB.2.02.1509151152430.24891@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 84A15260824
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 31CD12E44A
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:01 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BwvCCGlHyDP1 for <alsa-devel@alsa-project.org>;
 Tue, 15 Sep 2015 13:10:00 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 6F4F52E3B6
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:00 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 4FBAB14E8
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:00 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 443D314E5
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:00 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by seth.se.axis.com (Postfix) with ESMTP id 422BB3E049
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 13:10:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


When recording or playing back audio in a format where the number of =

significant bits is less than the physical width (e.g. S24_LE), the VU =

meter code needs to consider the number of significant bits in the samples =

rather than the physical sample width (e.g. 24 vs 32 bits). Otherwise the =

resulting VU meter display will be far too low and it will just indicate =

0% all the time.

Tested with a device supporting the S24_LE format.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---
 alsa-utils/aplay/aplay.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index e58e1bc..19b6a92 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -124,7 +124,7 @@ static int fatal_errors =3D 0;
 static int verbose =3D 0;
 static int vumeter =3D VUMETER_NONE;
 static int buffer_pos =3D 0;
-static size_t bits_per_sample, bits_per_frame;
+static size_t significant_bits_per_sample, bits_per_sample, bits_per_frame;
 static size_t chunk_bytes;
 static int test_position =3D 0;
 static int test_coef =3D 8;
@@ -1344,6 +1344,7 @@ static void set_params(void)
 		snd_pcm_dump(handle, log);
 =

 	bits_per_sample =3D snd_pcm_format_physical_width(hwparams.format);
+	significant_bits_per_sample =3D snd_pcm_format_width(hwparams.format);
 	bits_per_frame =3D bits_per_sample * hwparams.channels;
 	chunk_bytes =3D chunk_size * bits_per_frame / 8;
 	audiobuf =3D realloc(audiobuf, chunk_bytes);
@@ -1745,7 +1746,7 @@ static void compute_max_peak(u_char *data, size_t cou=
nt)
 		}
 		return;
 	}
-	max =3D 1 << (bits_per_sample-1);
+	max =3D 1 << (significant_bits_per_sample-1);
 	if (max <=3D 0)
 		max =3D 0x7fffffff;
 =

-- =

1.7.10.4


-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
