From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Tue, 15 Nov 2011 14:08:36 +0800
Message-ID: <CAHG8p1BnW6v9uqFJq_UHif5Hqu9K9qZ_QZYL0SbBFxF+iJVhHA@mail.gmail.com>
References: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
	<s5hbosngd04.wl%tiwai@suse.de>
	<CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
	<CAHG8p1AHr6Z7VY+6zVhGk6AkbZxdS+firK4eFVrg81NWJnEVNA@mail.gmail.com>
	<s5h8vni6ac4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3401F24585
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 07:08:40 +0100 (CET)
Received: by vcbfy13 with SMTP id fy13so6528272vcb.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 22:08:37 -0800 (PST)
In-Reply-To: <s5h8vni6ac4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/11/14 Takashi Iwai <tiwai@suse.de>:
> At Mon, 14 Nov 2011 17:53:10 +0800,
> Does your driver support mmap?

No, our tdm driver doesn't support mmap.

struct snd_pcm_ops bf5xx_pcm_tdm_ops =3D {
        .open           =3D bf5xx_pcm_open,
        .ioctl          =3D snd_pcm_lib_ioctl,
        .hw_params      =3D bf5xx_pcm_hw_params,
        .hw_free        =3D bf5xx_pcm_hw_free,
        .prepare        =3D bf5xx_pcm_prepare,
        .trigger        =3D bf5xx_pcm_trigger,
        .pointer        =3D bf5xx_pcm_pointer,
        .copy           =3D bf5xx_pcm_copy,
        .silence        =3D bf5xx_pcm_silence,
};
And only support s32_le and 48000
static const struct snd_pcm_hardware bf5xx_pcm_hardware =3D {
        .info =3D (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSF=
ER |
                SNDRV_PCM_INFO_RESUME),
        .formats =3D          SNDRV_PCM_FMTBIT_S32_LE,
        .rates =3D            SNDRV_PCM_RATE_48000,
        .channels_min =3D     2,
        .channels_max =3D     8,
        .buffer_bytes_max =3D PCM_BUFFER_MAX,
        .period_bytes_min =3D FRAGMENT_SIZE_MIN,
        .period_bytes_max =3D PCM_BUFFER_MAX/2,
        .periods_min =3D      FRAGMENTS_MIN,
        .periods_max =3D      FRAGMENTS_MAX,
};
> What shows aplay -v with the arguments above?
>
root:/> arecord -t wav -c 2 -r 48000 -f S16_LE -d 3 -v 1.wav
Recording WAVE '1.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Mmap emulation PCM
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'bfin-ad1836' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1073741824
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
root:/> arecord -t wav -c 2 -r 48000 -f S32_LE -d 3 -v 1.wav
Recording WAVE '1.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Mmap emulation PCM
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Hardware PCM card 0 'bfin-ad1836' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1073741824
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
arecord: pcm_read:1773: read error: Input/output error

> I know of a problem of mmap-emul plugin when it runs over a slave
> that supports the mmap by itself. =A0But it should work when it runs
> over a slave that doesn't support mmap.
>
I found this bug was introduced by this commit I mentioned.
>From aplay info above, it seems if there is no plugin prior to
mmap-emul, alsa lib will never send start cmd to driver.

Regards,
Scott
