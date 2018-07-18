From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: [PATCH RFC 16/26] ALSA: rme32: Convert to
	copy_silence ops
Date: Wed, 18 Jul 2018 12:22:11 +0200
Message-ID: <29B2CB39-BCFF-4A04-9406-80059409BDEE@exactcode.de>
References: <20170511210925.18208-1-tiwai@suse.de>
 <20170511210925.18208-17-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 230E426772E
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 12:22:25 +0200 (CEST)
In-Reply-To: <20170511210925.18208-17-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello everyone,

to have another digital audio i/o card for our studio / office, I got a pai=
r of RME32 the other week from ebay. (mostly as reference to implement ADAT=
 for the RAD1 Sgi/Octane ALSA driver, =85)

Unfortunately they do not work with Linux. They are recognised and all the =
usual devices and /proc/=85 entries show up, however, the hardware pointer =
does not move during playback or capture no matter what clock source I choo=
se.
I tried attaching coax s/pdif as well as an 8-channel Behringer Ultragain A=
DAT source w/ clock.

The two cards came from the same seller, look ok and both behave the same. =

I went so far to install a Windows XP test install where both cards work =
=93more=94.
(They are not perfect in windows, however, at least s/pdif can come out wit=
h or with-out external ADAT clock source. However, the digital signal stran=
gely unclean, but that may be a bug in the window system sound device emula=
tion, I only tested with foobar2k and not some Pro audio app which I do not=
 really have).

Long story short, does someone still have such a card, or not moving hardwa=
re ptr (or missing interrupts?) does ring a bell regarding this RME generat=
ion? Instead of a working ADAT reference card, I apparently have two ALSA d=
river to hack on, =85 ;-)

I tested two different =93PC=94 boards and the results were the same, too.

Thanks,
	Ren=E9

On 11 May 2017, at 23:09, Takashi Iwai <tiwai@suse.de> wrote:

> Replace the copy and the silence ops with the new merged ops.
> The conversion is straightforward with standard helper functions.
> =

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> sound/pci/rme32.c | 49 ++++++++++++++++++++++++-------------------------
> 1 file changed, 24 insertions(+), 25 deletions(-)
> =

> diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
> index 96d15db65dfd..d2b4a3ef0bd3 100644
> --- a/sound/pci/rme32.c
> +++ b/sound/pci/rme32.c
> @@ -253,41 +253,42 @@ static inline unsigned int snd_rme32_pcm_byteptr(st=
ruct rme32 * rme32)
> 		& RME32_RCR_AUDIO_ADDR_MASK);
> }
> =

> -/* silence callback for halfduplex mode */
> -static int snd_rme32_playback_silence(struct snd_pcm_substream *substrea=
m, int channel,	/* not used (interleaved data) */
> -				      snd_pcm_uframes_t pos,
> -				      snd_pcm_uframes_t count)
> -{
> -	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
> -	count <<=3D rme32->playback_frlog;
> -	pos <<=3D rme32->playback_frlog;
> -	memset_io(rme32->iobase + RME32_IO_DATA_BUFFER + pos, 0, count);
> -	return 0;
> -}
> -
> /* copy callback for halfduplex mode */
> -static int snd_rme32_playback_copy(struct snd_pcm_substream *substream, =
int channel,	/* not used (interleaved data) */
> +static int snd_rme32_playback_copy(struct snd_pcm_substream *substream,
> +				   int channel,	/* not used (interleaved data) */
> 				   snd_pcm_uframes_t pos,
> -				   void __user *src, snd_pcm_uframes_t count)
> +				   void __user *src, snd_pcm_uframes_t count,
> +				   bool in_kernel)
> {
> 	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
> 	count <<=3D rme32->playback_frlog;
> 	pos <<=3D rme32->playback_frlog;
> -	if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
> -			    src, count))
> +	if (!src)
> +		memset_io(rme32->iobase + RME32_IO_DATA_BUFFER + pos, 0, count);
> +	else if (in_kernel)
> +		memcpy_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
> +			    (void *)src, count);
> +	else if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
> +				     src, count))
> 		return -EFAULT;
> 	return 0;
> }
> =

> /* copy callback for halfduplex mode */
> -static int snd_rme32_capture_copy(struct snd_pcm_substream *substream, i=
nt channel,	/* not used (interleaved data) */
> +static int snd_rme32_capture_copy(struct snd_pcm_substream *substream,
> +				  int channel,	/* not used (interleaved data) */
> 				  snd_pcm_uframes_t pos,
> -				  void __user *dst, snd_pcm_uframes_t count)
> +				  void __user *dst, snd_pcm_uframes_t count,
> +				  bool in_kernel)
> {
> 	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
> 	count <<=3D rme32->capture_frlog;
> 	pos <<=3D rme32->capture_frlog;
> -	if (copy_to_user_fromio(dst,
> +	if (in_kernel)
> +		memcpy_fromio((void *)dst,
> +			      rme32->iobase + RME32_IO_DATA_BUFFER + pos,
> +			      count);
> +	else if (copy_to_user_fromio(dst,
> 			    rme32->iobase + RME32_IO_DATA_BUFFER + pos,
> 			    count))
> 		return -EFAULT;
> @@ -1205,8 +1206,7 @@ static const struct snd_pcm_ops snd_rme32_playback_=
spdif_ops =3D {
> 	.prepare =3D	snd_rme32_playback_prepare,
> 	.trigger =3D	snd_rme32_pcm_trigger,
> 	.pointer =3D	snd_rme32_playback_pointer,
> -	.copy =3D		snd_rme32_playback_copy,
> -	.silence =3D	snd_rme32_playback_silence,
> +	.copy_silence =3D	snd_rme32_playback_copy,
> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
> };
> =

> @@ -1219,7 +1219,7 @@ static const struct snd_pcm_ops snd_rme32_capture_s=
pdif_ops =3D {
> 	.prepare =3D	snd_rme32_capture_prepare,
> 	.trigger =3D	snd_rme32_pcm_trigger,
> 	.pointer =3D	snd_rme32_capture_pointer,
> -	.copy =3D		snd_rme32_capture_copy,
> +	.copy_silence =3D	snd_rme32_capture_copy,
> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
> };
> =

> @@ -1231,8 +1231,7 @@ static const struct snd_pcm_ops snd_rme32_playback_=
adat_ops =3D {
> 	.prepare =3D	snd_rme32_playback_prepare,
> 	.trigger =3D	snd_rme32_pcm_trigger,
> 	.pointer =3D	snd_rme32_playback_pointer,
> -	.copy =3D		snd_rme32_playback_copy,
> -	.silence =3D	snd_rme32_playback_silence,
> +	.copy_silence =3D	snd_rme32_playback_copy,
> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
> };
> =

> @@ -1244,7 +1243,7 @@ static const struct snd_pcm_ops snd_rme32_capture_a=
dat_ops =3D {
> 	.prepare =3D	snd_rme32_capture_prepare,
> 	.trigger =3D	snd_rme32_pcm_trigger,
> 	.pointer =3D	snd_rme32_capture_pointer,
> -	.copy =3D		snd_rme32_capture_copy,
> +	.copy_silence =3D	snd_rme32_capture_copy,
> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
> };
> =

> -- =

> 2.12.2
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE2516=
02478
 Managing Director: Ren=E9 Rebe
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
