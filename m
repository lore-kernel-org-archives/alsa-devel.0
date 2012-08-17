From: Andrew Eikum <aeikum@codeweavers.com>
Subject: [alsa-plugins PATCH] pulse: Support 24-bit formats
Date: Fri, 17 Aug 2012 15:41:07 -0500
Message-ID: <20120817204107.GV2424@foghorn.codeweavers.com>
Reply-To: alsa-devel <alsa-devel@alsa-project.org>,
 Andrew Eikum <aeikum@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u5E4XgoOPWr4PD9E"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.codeweavers.com (mail.codeweavers.com [216.251.189.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C990265230
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 22:11:24 +0200 (CEST)
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
To: alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Disposition: inline


These formats were introduced in PulseAudio 0.9.15. There aren't any
new formats supported since then, so this also brings the PulseAudio
plugin in sync with current PulseAudio.

Signed-off-by: Andrew Eikum <aeikum@codeweavers.com>
---

There was a problem once before with a patch I submitted. This is
using format-patch and imap-send, so hopefully it goes through better
than it did before :)

 pulse/pcm_pulse.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


--u5E4XgoOPWr4PD9E
Content-Type: text/x-patch; charset=us-ascii;
	name="0001-pulse-Support-24-bit-formats.patch"
Content-Disposition: inline; filename="0001-pulse-Support-24-bit-formats.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index e0fbd4c..24fd4da 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -820,6 +820,26 @@ static int pulse_hw_params(snd_pcm_ioplug_t * io,
 		pcm->ss.format =3D PA_SAMPLE_S32BE;
 		break;
 #endif
+#ifdef PA_SAMPLE_S24LE
+	case SND_PCM_FORMAT_S24_3LE:
+		pcm->ss.format =3D PA_SAMPLE_S24LE;
+		break;
+#endif
+#ifdef PA_SAMPLE_S24BE
+	case SND_PCM_FORMAT_S24_3BE:
+		pcm->ss.format =3D PA_SAMPLE_S24BE;
+		break;
+#endif
+#ifdef PA_SAMPLE_S24_32LE
+	case SND_PCM_FORMAT_S24_LE:
+		pcm->ss.format =3D PA_SAMPLE_S24_32LE;
+		break;
+#endif
+#ifdef PA_SAMPLE_S24_32BE
+	case SND_PCM_FORMAT_S24_BE:
+		pcm->ss.format =3D PA_SAMPLE_S24_32BE;
+		break;
+#endif
 	default:
 		SNDERR("PulseAudio: Unsupported format %s\n",
 			snd_pcm_format_name(io->format));

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--u5E4XgoOPWr4PD9E--
