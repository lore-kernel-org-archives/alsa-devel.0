From: "Daniel Schnell" <daniel.schnell@gmx.net>
Subject: Re: Bug: Alsa-lib 1.05 doesn't work with dmix plugin and noninterleaved mmap'ed access and regions-buffer ?
Date: Mon, 2 Aug 2004 11:03:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1bee01c4786f$9cd08230$2c0aa8c0@lumpidu>
References: <1b0d01c47649$a9f36f90$2c0aa8c0@lumpidu> <Pine.LNX.4.58.0407301934210.1767@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_1BEB_01C47880.5F9BCE90"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_1BEB_01C47880.5F9BCE90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The output fom snd_pcm_dump is attached. The output is the same for alsa-lib
v1.05 or 1.03.

Even if I get more frames available than configured because of delayed
hardware interrupts - how can I accomodate this with the zero copy approach
of mmaped operations ? Make another while loop around
snd_pcm_avail_update(), snd_pcm_mmap_begin(), snd_pcm_mmap_commit() to match
the buffer sizes of the internally allocated region buffers? If this is the
way to go: Ok. But it would be a clear inconveniance and furthermore no
documentation or sample code shows any hint for that.

If it's not a bug: why has this behavior changed since ALSA Lib v1.03 ? Here
I never get a "late interrupt".

Ciao,

Daniel.

----- Original Message ----- 
From: "Jaroslav Kysela" <perex@suse.cz>
To: "Daniel Schnell" <daniel.schnell@gmx.net>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Friday, July 30, 2004 7:37 PM
Subject: Re: [Alsa-devel] Bug: Alsa-lib 1.05 doesn't work with dmix plugin
and noninterleaved mmap'ed access and regions-buffer ?


> On Fri, 30 Jul 2004, Daniel Schnell wrote:
>
> > ...
> > 257 (!) frames avilable
> > 108 chunked 149 chunked
> > 511(!) frames available
> > 363 chunked 148 chunked
>
> Sorry, I don't understand this description.
> Also, the dump of PCM configuration would be nice for analysis
> (snd_pcm_dump()).
>
> > This seems to be where the problem arises, as I use the internal regions
> > buffers, which are certainly allocated only to 256 frames (1024 bytes)
> > and here a buffer overflow occurs. Afterwards the audio output ceases to
>
> You may get more frames available - it depends on hardware interrupt
> acknowledge (in some cases the interrupt is delayed by some reason).
>
> Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>

------=_NextPart_000_1BEB_01C47880.5F9BCE90
Content-Type: application/octet-stream;
	name="dump.pcm"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dump.pcm"

Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)=0A=
Its setup is:=0A=
stream       : PLAYBACK=0A=
access       : MMAP_NONINTERLEAVED=0A=
format       : FLOAT_LE=0A=
subformat    : STD=0A=
channels     : 2=0A=
rate         : 48000=0A=
exact rate   : 48000 (48000/1)=0A=
msbits       : 32=0A=
buffer_size  : 512=0A=
period_size  : 256=0A=
period_time  : 5333=0A=
tick_time    : 0=0A=
tstamp_mode  : NONE=0A=
period_step  : 1=0A=
sleep_min    : 0=0A=
avail_min    : 256=0A=
xfer_align   : 1=0A=
start_threshold  : 0=0A=
stop_threshold   : 511=0A=
silence_threshold: 0=0A=
silence_size : 0=0A=
boundary     : 1073741824=0A=
Slave: Direct Stream Mixing PCM=0A=
=0A=
Its setup is:=0A=
stream       : PLAYBACK=0A=
access       : MMAP_INTERLEAVED=0A=
format       : S16_LE=0A=
subformat    : STD=0A=
channels     : 2=0A=
rate         : 48000=0A=
exact rate   : 48000 (48000/1)=0A=
msbits       : 16=0A=
buffer_size  : 512=0A=
period_size  : 256=0A=
period_time  : 5333=0A=
tick_time    : 0=0A=
tstamp_mode  : NONE=0A=
period_step  : 1=0A=
sleep_min    : 0=0A=
avail_min    : 256=0A=
xfer_align   : 1=0A=
start_threshold  : 0=0A=
stop_threshold   : 511=0A=
silence_threshold: 0=0A=
silence_size : 0=0A=
boundary     : 1073741824=0A=
Hardware PCM card 0 'SiS SI7012' device 0 subdevice 0=0A=
=0A=
Its setup is:=0A=
stream       : PLAYBACK=0A=
access       : MMAP_INTERLEAVED=0A=
format       : S16_LE=0A=
subformat    : STD=0A=
channels     : 2=0A=
rate         : 48000=0A=
exact rate   : 48000 (48000/1)=0A=
msbits       : 16=0A=
buffer_size  : 512=0A=
period_size  : 256=0A=
period_time  : 5333=0A=
tick_time    : 10000=0A=
tstamp_mode  : NONE=0A=
period_step  : 1=0A=
sleep_min    : 0=0A=
avail_min    : 256=0A=
xfer_align   : 256=0A=
start_threshold  : 1=0A=
stop_threshold   : 1073741824=0A=
silence_threshold: 0=0A=
silence_size : 1073741824=0A=
boundary     : 1073741824=0A=

------=_NextPart_000_1BEB_01C47880.5F9BCE90--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
