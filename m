From: Christophe Aeschlimann <c.aeschlimann-5/WUhD8XThOVQ4qyx6sgCw@public.gmane.org>
Subject: davinci-pcm.c : snd_pcm_hardware.periods_min value
Date: Thu, 5 Jul 2012 10:52:14 +0200
Message-ID: <4FF555BE.7090509@acn-group.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, vbarinov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

We are working with an OMAP-L138 attached to a TI stereo codec
(TLV320AIC3107) using McASP and we are trying to reduce the latency on
the playback path.

We are using the real-time patches on a 3.0.y longterm stable kernel.

In /sound/soc/davinci/davinci-pcm.c I can see the following structure:

> static struct snd_pcm_hardware pcm_hardware_playback =3D {
> 	.info =3D (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
> 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
> 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
> 	.formats =3D (SNDRV_PCM_FMTBIT_S16_LE),
> 	.rates =3D (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
> 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
> 		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
> 		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
> 		  SNDRV_PCM_RATE_KNOT),
> 	.rate_min =3D 8000,
> 	.rate_max =3D 96000,
> 	.channels_min =3D 2,
> 	.channels_max =3D 2,
> 	.buffer_bytes_max =3D 128 * 1024,
> 	.period_bytes_min =3D 32,
> 	.period_bytes_max =3D 8 * 1024,
> 	.periods_min =3D 16,
> 	.periods_max =3D 255,
> 	.fifo_size =3D 0,
> };

Which I think affects the minimum latency achievable.

I would like to know if there is a reason why the periods_min is set to
such a high value (16) ? (comparatively to most drivers).

I'd welcome any information :)

Best regards,
-- =

Christophe Aeschlimann

Embedded Software Engineer & IT Manager
ACN Advanced Communications Networks S.A.
2000 - Neuch=E2tel, Switzerland
Tel. +41 32 724 74 31
