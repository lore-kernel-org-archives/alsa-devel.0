From: Eran Ben-Avi <eranpublic@yahoo.com>
Subject: Re: Noisy USB audio stream using MPlayer
Date: Tue, 23 Jun 2009 03:03:43 -0700 (PDT)
Message-ID: <892610.27572.qm@web62507.mail.re1.yahoo.com>
References: <786354.70664.qm@web62506.mail.re1.yahoo.com>
	<s5h4ou8cjbk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web62507.mail.re1.yahoo.com (web62507.mail.re1.yahoo.com
	[69.147.75.99]) by alsa0.perex.cz (Postfix) with SMTP id B100324644
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 12:03:45 +0200 (CEST)
In-Reply-To: <s5h4ou8cjbk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org






----- Original Message ----
> From: Takashi Iwai <tiwai@suse.de>
> To: Eran Ben-Avi <eranpublic@yahoo.com>
> Cc: alsa-devel@alsa-project.org
> Sent: Monday, June 22, 2009 7:41:19 PM
> Subject: Re: [alsa-devel] Noisy USB audio stream using MPlayer
> =

> At Mon, 22 Jun 2009 01:17:25 -0700 (PDT),
> Eran Ben-Avi wrote:
> > =

> > =

> > Hi,
> > =

> > I encountered some issue with my USB audio device and couldn't find any =

> similar issue in previous mailing lists, any help will be appreciated.
> > When playing an audio stream using MPlayer Ver1.0rc2-4.1.2=A0(tried dif=
ferent =

> sample rates=A044K, 48K and different files WAV , MP3)=A0using my Creativ=
e SB0271 =

> USB device on ARM based system(Marvell Kirkwood SoC) and kernel 2.6.22.18=
, I =

> hear an=A0interfering constant noise additionally to the original audio s=
tream.
> > At the beginning I heard this noise also when I used aplay(for WAV) but=
 after =

> I reinstalled the ALSA-LIB and ALSA-UTILS(version 1.0.14rc4), the aplay s=
uddenly =

> started to work smooth.
> > I tested different USB audio device(AKM) but got same noisy results.
> > Another piece of information I can provide is that increasing the CPU =

> utilization eliminates the noise completely - maybe a timing issue ???
> =

> Could it be the cache coherency?
> The usb-audio driver uses vmalloc'ed buffers as intermediate buffers,
> and they can be=A0 exposed to user-space via mmap.
> =

> Does the problem disappears when you disable mmap support by
> commenting out SNDRV_PCM_INFO_MMAP* in snd_usb_hardware info field?

When I disabled the mmap support I got the following messages while running=
 the mplayer:

[AO_ALSA] alsa-lib: pcm_direct.c:874:(snd_pcm_direct_initialize_slave) slav=
e plugin does not support mmap interleaved or mmap
=A0noninterleaved access
[AO_ALSA] alsa-lib: pcm_dmix.c:876:(snd_pcm_dmix_open) unable to initialize=
 slave
[AO_ALSA] Playback open error: Invalid argument
Opening /dev/dvb/adapter0/audio0
DVB AUDIO DEVICE: No such file or directory

seems like=A0ALSA-LIB=A0doesn't really like it.

Thanks,
Eran
=A0
> =

> =

> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



      =
