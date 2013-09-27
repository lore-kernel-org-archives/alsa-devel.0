From: Rob Sykes <aquegg@yahoo.co.uk>
Subject: pcm_rate API  question
Date: Fri, 27 Sep 2013 12:59:33 +0100 (BST)
Message-ID: <1380283173.50500.YahooMailNeo@web171404.mail.ir2.yahoo.com>
Reply-To: Rob Sykes <aquegg@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm5-vm0.bullet.mail.ird.yahoo.com
 (nm5-vm0.bullet.mail.ird.yahoo.com [77.238.189.207])
 by alsa0.perex.cz (Postfix) with SMTP id BCF2C265079
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:59:35 +0200 (CEST)
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

Hello alsa devs,

There's an ongoing attempt to see if libsoxr-lsr can be used as a plug-in r=
eplacement for libsamplerate in pulseaudio and in alsa (libsoxr-lsr is desi=
gned with this usage in mind).

With pulseaudio, it seems to 'just work', but with alsa, it looks like ther=
e is a buffering problem. =A0Progress reports for this are here:

http://blog.ivitera.com/pavel/linux-audio/pulseaudio-with-ld_preloading-lib=
soxr-lsr

http://blog.ivitera.com/pavel/linux-audio/simple-use-of-libsoxr-lsr-in-alsa=
-using-ld_preload


AFAICT, the problem with alsa relates to the use of this function in pcm_ra=
te.h:

typedef struct snd_pcm_rate_ops {
...
=A0 =A0 =A0 =A0 void (*convert_s16)(void *obj, int16_t *dst, unsigned int d=
st_frames,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const int16_t *src,=
 unsigned int src_frames);

Is there documentation available regarding the use of this function? For ex=
ample, is the plugin obliged always to consume=A0src_frames and generate=A0=
dst_frames samples? =A0If so, how is the plugin expected to comply (say, if=
 it's not been given enough input to generate that amount of output)?

TIA,
Rob
