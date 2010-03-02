From: Bart De Vos <bart_dv@eia.be>
Subject: dmix format S24_LE
Date: Tue, 02 Mar 2010 13:20:08 +0100
Message-ID: <4B8D0278.2040101@eia.be>
Reply-To: bart_dv@eia.be
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eia.be (gate.eia.be [194.78.71.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 69380103817
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 13:18:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I've added support for the S24_LE format in the dmix plugin. This has =

been tested 'only' on i.MX31 (arm11) with sound DAC AK4367 over I2S, =

which supports this format natively.

Patch is against alsa-lib-1.0.22.

Please let me know your thoughts.

diff -urN alsa-lib-1.0.22-orig/src/pcm/pcm_direct.c =

alsa-lib-1.0.22/src/pcm/pcm_direct.c
--- alsa-lib-1.0.22-orig/src/pcm/pcm_direct.c	2009-12-16 =

16:18:51.000000000 +0100
+++ alsa-lib-1.0.22/src/pcm/pcm_direct.c	2010-03-02 10:01:00.000000000 +0100
@@ -888,6 +888,7 @@
  			SND_PCM_FORMAT_S32 ^ SND_PCM_FORMAT_S32_LE ^ SND_PCM_FORMAT_S32_BE,
  			SND_PCM_FORMAT_S16,
  			SND_PCM_FORMAT_S16 ^ SND_PCM_FORMAT_S16_LE ^ SND_PCM_FORMAT_S16_BE,
+			SND_PCM_FORMAT_S24_LE,
  			SND_PCM_FORMAT_S24_3LE,
  			SND_PCM_FORMAT_U8,
  		};
diff -urN alsa-lib-1.0.22-orig/src/pcm/pcm_dmix.c =

alsa-lib-1.0.22/src/pcm/pcm_dmix.c
--- alsa-lib-1.0.22-orig/src/pcm/pcm_dmix.c	2009-12-16 =

16:18:51.000000000 +0100
+++ alsa-lib-1.0.22/src/pcm/pcm_dmix.c	2010-03-02 10:02:39.000000000 +0100
@@ -174,6 +174,10 @@
  		sample_size =3D 4;
  		do_mix_areas =3D (mix_areas_t *)dmix->u.dmix.mix_areas_32;
  		break;
+	case SND_PCM_FORMAT_S24_LE:
+		sample_size =3D 4;
+		do_mix_areas =3D (mix_areas_t *)dmix->u.dmix.mix_areas_24;
+		break;
  	case SND_PCM_FORMAT_S24_3LE:
  		sample_size =3D 3;
  		do_mix_areas =3D (mix_areas_t *)dmix->u.dmix.mix_areas_24;
@@ -238,6 +242,10 @@
  		sample_size =3D 4;
  		do_remix_areas =3D (mix_areas_t *)dmix->u.dmix.remix_areas_32;
  		break;
+	case SND_PCM_FORMAT_S24_LE:
+		sample_size =3D 4;
+		do_remix_areas =3D (mix_areas_t *)dmix->u.dmix.remix_areas_24;
+		break;
  	case SND_PCM_FORMAT_S24_3LE:
  		sample_size =3D 3;
  		do_remix_areas =3D (mix_areas_t *)dmix->u.dmix.remix_areas_24;
diff -urN alsa-lib-1.0.22-orig/src/pcm/pcm_dmix_generic.c =

alsa-lib-1.0.22/src/pcm/pcm_dmix_generic.c
--- alsa-lib-1.0.22-orig/src/pcm/pcm_dmix_generic.c	2009-12-16 =

16:18:51.000000000 +0100
+++ alsa-lib-1.0.22/src/pcm/pcm_dmix_generic.c	2010-03-02 =

10:37:16.000000000 +0100
@@ -122,7 +122,7 @@
  #define generic_dmix_supported_format \
  	((1ULL << SND_PCM_FORMAT_S16_LE) | (1ULL << SND_PCM_FORMAT_S32_LE) |\
  	 (1ULL << SND_PCM_FORMAT_S16_BE) | (1ULL << SND_PCM_FORMAT_S32_BE) |\
-	 (1ULL << SND_PCM_FORMAT_S24_3LE) | \
+	 (1ULL << SND_PCM_FORMAT_S24_LE) | (1ULL << SND_PCM_FORMAT_S24_3LE)|\
  	 (1ULL << SND_PCM_FORMAT_U8))

  #include <byteswap.h>

-- =

--------------------------------------------------
Bart De Vos
Development Engineer
mailto:bart.devos@eia.be

EIA Electronics
Vluchtenburgstraat  3
B-2630 Aartselaar  (Belgium)
phone	: +32(0)3 870 85 29
fax    	: +32(0)3 877 14 72
website	: http://www.eia.be/
--------------------------------------------------
Basically, perfect development is impossible.
Development can be fast, good and cheap. Pick two!
=97 Larry Wall
--------------------------------------------------
