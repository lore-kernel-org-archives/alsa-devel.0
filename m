From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Problems with a PCM driver
Date: Sat, 30 Aug 2003 19:56:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308301956.52235.adrian@mcmen.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA22718
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2003 20:56:48 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am writing a PCM driver for the AICA device on the Sega Dreamcast for a=
=20
2.6.0-testX kernel.

The driver is far from complete, but I am having various problems when I =
test=20
bits of it...

A simple write of a file gives me this...

/dev/snd # cat /test.txt > pcmC0D0p
ALSA sound/sh/aica.c:165: In snd_aica_playback_open
ALSA sound/sh/aica.c:80: Disabling AICA device
ALSA sound/sh/aica.c:66: Enabling AICA device
cat: write: File descriptor in bad state

The three snd_printk messages are just what I would expect but I am not s=
ure=20
why I get the message about the file descriptor.

Here is the open function...

static int snd_aica_playback_open(snd_pcm_substream_t *subs)
{
=09snd_printk("In snd_aica_playback_open \n");
=09snd_aica_pcm_t *aica_chip =3D snd_pcm_substream_chip(subs);
=09snd_pcm_runtime_t *runtime =3D subs->runtime;
=09runtime->hw =3D snd_aica_playback_hw;


=09/*setup the aica spu*/
=09
=09spu_disable();
=09spu_memset(0, 0, 0x31000);
=09spu_memload(0, bin_arm7, sizeof(bin_arm7));
=09spu_enable();

=09
=09return 0;
}


The device doesn't support dma (or rather nobody has yet successful rever=
sed=20
the DMA mechanism) and so I am using the methods that worked when I wrote=
 the=20
OSS driver for the 2.4 kernels.

snd_aica_playback_hw is...

static snd_pcm_hardware_t snd_aica_playback_hw =3D {
=09.info =3D SNDRV_PCM_INFO_INTERLEAVED|SNDRV_PCM_INFO_NONINTERLEAVED,
=09.formats =3D SNDRV_PCM_FORMAT_S8 | SNDRV_PCM_FORMAT_U8 |=20
SNDRV_PCM_FORMAT_S16_LE | SNDRV_PCM_FORMAT_IMA_ADPCM,
=09.rates =3D SNDRV_PCM_RATE_8000_44100,
=09.rate_min =3D 8000,
=09.rate_max =3D 44100,
=09.channels_min =3D 1,
=09.channels_max =3D 2,
=09.buffer_bytes_max =3D 32768,
=09.period_bytes_min =3D 8192,
=09.period_bytes_max =3D 32768,
=09.periods_min =3D 1,
=09.periods_max =3D 4
};

Anybody able to give me a few pointers as to what is going wrong?

Thanks

Adrian


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
