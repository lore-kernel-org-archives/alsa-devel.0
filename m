From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: [PATCH RFC 16/26] ALSA: rme32: Convert to
	copy_silence ops
Date: Thu, 19 Jul 2018 10:09:37 +0200
Message-ID: <D1490A9B-6437-4DDE-A2F8-B6B09D414B46@exactcode.de>
References: <20170511210925.18208-1-tiwai@suse.de>
 <20170511210925.18208-17-tiwai@suse.de>
 <29B2CB39-BCFF-4A04-9406-80059409BDEE@exactcode.de>
 <s5hva9cbymf.wl-tiwai@suse.de>
 <91F60AF4-0A8B-4165-9B21-F744C8F1716B@exactcode.de>
 <AA13A776-DBEE-465F-8160-F77CB9B0EC89@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A4F2675FC
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 10:09:48 +0200 (CEST)
In-Reply-To: <AA13A776-DBEE-465F-8160-F77CB9B0EC89@exactcode.de>
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

Hi,

On 18 Jul 2018, at 20:43, Ren=E9 Rebe <rene@exactcode.de> wrote:

> Hi,
> =

> On 18 Jul 2018, at 20:10, Ren=E9 Rebe <rene@exactcode.de> wrote:
> =

>> Hi,
>> =

>> On 18 Jul 2018, at 12:56, Takashi Iwai <tiwai@suse.de> wrote:
>> =

>>> On Wed, 18 Jul 2018 12:22:11 +0200,
>>> Ren=E9 Rebe wrote:
>>>> =

>>>> Hello everyone,
>>>> =

>>>> to have another digital audio i/o card for our studio / office, I got =
a pair of RME32 the other week from ebay. (mostly as reference to implement=
 ADAT for the RAD1 Sgi/Octane ALSA driver, =85)
>>>> =

>>>> Unfortunately they do not work with Linux. They are recognised and all=
 the usual devices and /proc/=85 entries show up, however, the hardware poi=
nter does not move during playback or capture no matter what clock source I=
 choose.
>>>> I tried attaching coax s/pdif as well as an 8-channel Behringer Ultrag=
ain ADAT source w/ clock.
>>> =

>>> Does the /proc/asound/card*/rme32 entry show the right setup?
>> =

>> Well, I think it never showed external clock when I set it to external A=
DAT, right now, freshly booted (without the ext. ADAT) just trying to play =
stereo on the s/pdif it shows:
> =

> as initial step getting familiar with this thing, I added some prink=92s,=
 I get exactly one interrupt each time I start a playback:
> =

> $ dmesg =

> [    0.000000] rme32 int: 86008004 80000000
> [    0.000000] CONFIRM_IRQ
> [    0.000000] IRQ_HANDLED
> $ grep rme32 /proc/interrupts =

>  5:          4    XT-PIC      snd_rme32

also dumping the read and write control words, I realize:

  rcreg: 6000000
  wcreg: 218

that the error bit is set, =85
#define RME32_RCR_ERF       (1 << 26)   /* 1=3DError, 0=3Dno Error */

as well as not documented as macro bit 25, =85 hm, =85

Does anyone still happen to have some documentation for this card ;-)?

	Ren=E9

> hm, =85 at least some io access and interrupt is happening, ...
> =

>> RME Digi32/8 (Rev. 101) at 0xec000000, irq 5 (index #1)
>> =

>> General settings
>> Half-duplex mode
>> receiver: CS8412
>> format: 16 bit, Stereo
>> =

>> Input settings
>> input: optical
>> sample rate: no valid signal
>> =

>> Output settings
>> output signal: normal playback (muted)
>> sample rate: 44100 Hz
>> sample clock source: Internal
>> format: IEC958 (consumer)
>> emphasis: off
>> =

>> Which should be right for internally word clock=92ed s/pdif output. Howe=
ver, aplay does not play anything, after some 20? seconds or so of hanging =
it even prints:
>> =

>> aplay: pcm_write:2011: write error: Input/output error
>> =

>> While it is =93trying to playback=94 /proc shows:
>> =

>> root@hostname:/proc/asound/card0# grep . pcm*p/sub0/*
>> pcm0p/sub0/hw_params:access: RW_INTERLEAVED
>> pcm0p/sub0/hw_params:format: S16_LE
>> pcm0p/sub0/hw_params:subformat: STD
>> pcm0p/sub0/hw_params:channels: 2
>> pcm0p/sub0/hw_params:rate: 44100 (44100/1)
>> pcm0p/sub0/hw_params:period_size: 2048
>> pcm0p/sub0/hw_params:buffer_size: 32768
>> pcm0p/sub0/info:card: 0
>> pcm0p/sub0/info:device: 0
>> pcm0p/sub0/info:subdevice: 0
>> pcm0p/sub0/info:stream: PLAYBACK
>> pcm0p/sub0/info:id: Digi32 IEC958
>> pcm0p/sub0/info:name: Digi32 IEC958
>> pcm0p/sub0/info:subname: subdevice #0
>> pcm0p/sub0/info:class: 0
>> pcm0p/sub0/info:subclass: 0
>> pcm0p/sub0/info:subdevices_count: 1
>> pcm0p/sub0/info:subdevices_avail: 0
>> pcm0p/sub0/status:state: RUNNING
>> pcm0p/sub0/status:owner_pid   : 753
>> pcm0p/sub0/status:trigger_time: 1195.174967384
>> pcm0p/sub0/status:tstamp      : 0.000000000
>> pcm0p/sub0/status:delay       : 32768
>> pcm0p/sub0/status:avail       : 0
>> pcm0p/sub0/status:avail_max   : 30720
>> pcm0p/sub0/status:-----
>> pcm0p/sub0/status:hw_ptr      : 10243
>> pcm0p/sub0/status:appl_ptr    : 43011
>> pcm0p/sub0/sw_params:tstamp_mode: NONE
>> pcm0p/sub0/sw_params:period_step: 1
>> pcm0p/sub0/sw_params:avail_min: 2048
>> pcm0p/sub0/sw_params:start_threshold: 32768
>> pcm0p/sub0/sw_params:stop_threshold: 32768
>> pcm0p/sub0/sw_params:silence_threshold: 0
>> pcm0p/sub0/sw_params:silence_size: 0
>> pcm0p/sub0/sw_params:boundary: 1073741824
>> =

>> I tried many kernels, down to 2.6.31, which I had initially on the box.
>> So unless some this hwparams never worked, this driver appears to not wo=
rk a looong looooong time.
>> =

>> I doubt they are fully defect, as both behave the same and at least outp=
ut =93something=94 on Windows XP, ...
>> =

>>> RME32 seems to have only few registers, and it behaves differently for
>>> read and write.  Maybe you should try to watch the register 0x20000.
>>> The hwptr is the LSB 33 bits.
>> =

>> Yeah, guess I have to instrument this driver to track what is happening,=
 maybe register not flushed to the hw?
>> =

>>> Takashi
>>> =

>>>> The two cards came from the same seller, look ok and both behave the s=
ame. =

>>>> I went so far to install a Windows XP test install where both cards wo=
rk =93more=94.
>>>> (They are not perfect in windows, however, at least s/pdif can come ou=
t with or with-out external ADAT clock source. However, the digital signal =
strangely unclean, but that may be a bug in the window system sound device =
emulation, I only tested with foobar2k and not some Pro audio app which I d=
o not really have).
>>>> =

>>>> Long story short, does someone still have such a card, or not moving h=
ardware ptr (or missing interrupts?) does ring a bell regarding this RME ge=
neration? Instead of a working ADAT reference card, I apparently have two A=
LSA driver to hack on, =85 ;-)
>>>> =

>>>> I tested two different =93PC=94 boards and the results were the same, =
too.
>>>> =

>>>> Thanks,
>>>> 	Ren=E9
>>>> =

>>>> On 11 May 2017, at 23:09, Takashi Iwai <tiwai@suse.de> wrote:
>>>> =

>>>>> Replace the copy and the silence ops with the new merged ops.
>>>>> The conversion is straightforward with standard helper functions.
>>>>> =

>>>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>>>> ---
>>>>> sound/pci/rme32.c | 49 ++++++++++++++++++++++++----------------------=
---
>>>>> 1 file changed, 24 insertions(+), 25 deletions(-)
>>>>> =

>>>>> diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
>>>>> index 96d15db65dfd..d2b4a3ef0bd3 100644
>>>>> --- a/sound/pci/rme32.c
>>>>> +++ b/sound/pci/rme32.c
>>>>> @@ -253,41 +253,42 @@ static inline unsigned int snd_rme32_pcm_bytept=
r(struct rme32 * rme32)
>>>>> 		& RME32_RCR_AUDIO_ADDR_MASK);
>>>>> }
>>>>> =

>>>>> -/* silence callback for halfduplex mode */
>>>>> -static int snd_rme32_playback_silence(struct snd_pcm_substream *subs=
tream, int channel,	/* not used (interleaved data) */
>>>>> -				      snd_pcm_uframes_t pos,
>>>>> -				      snd_pcm_uframes_t count)
>>>>> -{
>>>>> -	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
>>>>> -	count <<=3D rme32->playback_frlog;
>>>>> -	pos <<=3D rme32->playback_frlog;
>>>>> -	memset_io(rme32->iobase + RME32_IO_DATA_BUFFER + pos, 0, count);
>>>>> -	return 0;
>>>>> -}
>>>>> -
>>>>> /* copy callback for halfduplex mode */
>>>>> -static int snd_rme32_playback_copy(struct snd_pcm_substream *substre=
am, int channel,	/* not used (interleaved data) */
>>>>> +static int snd_rme32_playback_copy(struct snd_pcm_substream *substre=
am,
>>>>> +				   int channel,	/* not used (interleaved data) */
>>>>> 				   snd_pcm_uframes_t pos,
>>>>> -				   void __user *src, snd_pcm_uframes_t count)
>>>>> +				   void __user *src, snd_pcm_uframes_t count,
>>>>> +				   bool in_kernel)
>>>>> {
>>>>> 	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
>>>>> 	count <<=3D rme32->playback_frlog;
>>>>> 	pos <<=3D rme32->playback_frlog;
>>>>> -	if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
>>>>> -			    src, count))
>>>>> +	if (!src)
>>>>> +		memset_io(rme32->iobase + RME32_IO_DATA_BUFFER + pos, 0, count);
>>>>> +	else if (in_kernel)
>>>>> +		memcpy_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
>>>>> +			    (void *)src, count);
>>>>> +	else if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER +=
 pos,
>>>>> +				     src, count))
>>>>> 		return -EFAULT;
>>>>> 	return 0;
>>>>> }
>>>>> =

>>>>> /* copy callback for halfduplex mode */
>>>>> -static int snd_rme32_capture_copy(struct snd_pcm_substream *substrea=
m, int channel,	/* not used (interleaved data) */
>>>>> +static int snd_rme32_capture_copy(struct snd_pcm_substream *substrea=
m,
>>>>> +				  int channel,	/* not used (interleaved data) */
>>>>> 				  snd_pcm_uframes_t pos,
>>>>> -				  void __user *dst, snd_pcm_uframes_t count)
>>>>> +				  void __user *dst, snd_pcm_uframes_t count,
>>>>> +				  bool in_kernel)
>>>>> {
>>>>> 	struct rme32 *rme32 =3D snd_pcm_substream_chip(substream);
>>>>> 	count <<=3D rme32->capture_frlog;
>>>>> 	pos <<=3D rme32->capture_frlog;
>>>>> -	if (copy_to_user_fromio(dst,
>>>>> +	if (in_kernel)
>>>>> +		memcpy_fromio((void *)dst,
>>>>> +			      rme32->iobase + RME32_IO_DATA_BUFFER + pos,
>>>>> +			      count);
>>>>> +	else if (copy_to_user_fromio(dst,
>>>>> 			    rme32->iobase + RME32_IO_DATA_BUFFER + pos,
>>>>> 			    count))
>>>>> 		return -EFAULT;
>>>>> @@ -1205,8 +1206,7 @@ static const struct snd_pcm_ops snd_rme32_playb=
ack_spdif_ops =3D {
>>>>> 	.prepare =3D	snd_rme32_playback_prepare,
>>>>> 	.trigger =3D	snd_rme32_pcm_trigger,
>>>>> 	.pointer =3D	snd_rme32_playback_pointer,
>>>>> -	.copy =3D		snd_rme32_playback_copy,
>>>>> -	.silence =3D	snd_rme32_playback_silence,
>>>>> +	.copy_silence =3D	snd_rme32_playback_copy,
>>>>> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
>>>>> };
>>>>> =

>>>>> @@ -1219,7 +1219,7 @@ static const struct snd_pcm_ops snd_rme32_captu=
re_spdif_ops =3D {
>>>>> 	.prepare =3D	snd_rme32_capture_prepare,
>>>>> 	.trigger =3D	snd_rme32_pcm_trigger,
>>>>> 	.pointer =3D	snd_rme32_capture_pointer,
>>>>> -	.copy =3D		snd_rme32_capture_copy,
>>>>> +	.copy_silence =3D	snd_rme32_capture_copy,
>>>>> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
>>>>> };
>>>>> =

>>>>> @@ -1231,8 +1231,7 @@ static const struct snd_pcm_ops snd_rme32_playb=
ack_adat_ops =3D {
>>>>> 	.prepare =3D	snd_rme32_playback_prepare,
>>>>> 	.trigger =3D	snd_rme32_pcm_trigger,
>>>>> 	.pointer =3D	snd_rme32_playback_pointer,
>>>>> -	.copy =3D		snd_rme32_playback_copy,
>>>>> -	.silence =3D	snd_rme32_playback_silence,
>>>>> +	.copy_silence =3D	snd_rme32_playback_copy,
>>>>> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
>>>>> };
>>>>> =

>>>>> @@ -1244,7 +1243,7 @@ static const struct snd_pcm_ops snd_rme32_captu=
re_adat_ops =3D {
>>>>> 	.prepare =3D	snd_rme32_capture_prepare,
>>>>> 	.trigger =3D	snd_rme32_pcm_trigger,
>>>>> 	.pointer =3D	snd_rme32_capture_pointer,
>>>>> -	.copy =3D		snd_rme32_capture_copy,
>>>>> +	.copy_silence =3D	snd_rme32_capture_copy,
>>>>> 	.mmap =3D		snd_pcm_lib_mmap_iomem,
>>>>> };
>>>>> =

>>>>> -- =

>>>>> 2.12.2
>>>>> =

>>>>> _______________________________________________
>>>>> Alsa-devel mailing list
>>>>> Alsa-devel@alsa-project.org
>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>> =

>>>> -- =

>>>> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>>>> DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE=
251602478
>>>> Managing Director: Ren=E9 Rebe
>>>> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http=
://t2-project.org | http://rene.rebe.de
>>>> =

>> =

>> -- =

>> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
>> DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE25=
1602478
>> Managing Director: Ren=E9 Rebe
>> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http:/=
/t2-project.org | http://rene.rebe.de
>> =

> =

> -- =

> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
> DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE251=
602478
> Managing Director: Ren=E9 Rebe
> http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://=
t2-project.org | http://rene.rebe.de
> =


-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: DE2516=
02478
 Managing Director: Ren=E9 Rebe
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
