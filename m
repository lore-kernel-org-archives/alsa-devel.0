From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Fri, 10 Sep 2004 08:46:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910064607.GG4584@sunrise.pg.gda.pl>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk> <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz> <20040906204559.GA4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071050020.1723@linux.local> <20040907103408.GB4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409071538390.14771@linux.local> <20040908171537.GC4584@sunrise.pg.gda.pl> <20040909122253.GE4584@sunrise.pg.gda.pl> <Pine.LNX.4.58.0409091728420.4150@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3742A278
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 08:46:17 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091728420.4150@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 09, 2004 at 05:29:20PM +0200, Jaroslav Kysela wrote:
> On Thu, 9 Sep 2004, Adam Tla/lka wrote:
> 
> > On Wed, Sep 08, 2004 at 07:15:37PM +0200, Adam Tla/lka wrote:
> > > BTW another case:
> > > 
> > > if avail = snd_pcm_available() > alsa.buffer_size then I think
> > > that frames_to_forward = avail - alsa.buffer_size
> > > 
> > > now I do err = snd_pcm_forward(pcm, frames_to_forward)
> > > and returned err is equal to avail
> > >
> > More:
> > first snd_pcm_forward results in err == 0 and next mmap_update call
> > reports bigger avail value and after snd_pcm_forward  snd_pcm_mmap_begin 
> > reports that there is no frames available to update.
> > 
> > Anyway even if I do err = snd_pcm_forward(pcm, 1) I get always 
> > err = avail or err == 0.
> > Why?
> 
> Show me the contents from snd_pcm_dump().

OK - some data below:

playback setup dump:
boundary     : 986447872
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 15052
period_size  : 940
period_time  : 21333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 940
xfer_align   : 940
start_threshold  : 1
stop_threshold   : 15052
silence_threshold: 0
silence_size : 0
boundary     : 986447872

ioctl(6, SNDCTL_DSP_GETOPTR, 0xbffff708) -> {1085944 1 37368}
ioctl(6, SNDCTL_DSP_GETOPTR, 
AOSS: buffer_size=15052 avail=82328 forwarded=0 ERR // after snd_pcm_forward
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 15052
period_size  : 940
period_time  : 21333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 940
xfer_align   : 1
start_threshold  : 940
stop_threshold   : 2147483647
silence_threshold: 0
silence_size : 0
boundary     : 986447872

Slave: Direct Stream Mixing PCM

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 1024
period_time  : 21333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Intel 82801BA-ICH2' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 1024
period_time  : 21333
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 1
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 1073741824
boundary     : 1073741824
0xbffff708) -> {1415368 160 39112}

ioctl(6, SNDCTL_DSP_GETOPTR, 
AOSS: buffer_size=15052 avail=82671 forwarded=82671 // after snd_pcm_forward
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 15052
period_size  : 940
period_time  : 21333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 940
xfer_align   : 1
start_threshold  : 940
stop_threshold   : 2147483647
silence_threshold: 0
silence_size : 0
boundary     : 986447872
Slave: Direct Stream Mixing PCM

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 1024
period_time  : 21333
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 1024
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Intel 82801BA-ICH2' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 16384
period_size  : 1024
period_time  : 21333
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 1
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 1073741824
boundary     : 1073741824
0xbffff708) -> {1416720 0 40464}
ioctl(6, SNDCTL_DSP_GETOPTR, 0xbffff708) -> {1419232 1 42976}
.
.
.

So as you can see I waste two ioctl's time.
First snd_pcm_forward reports err == 0 and the second one reports
err == avail and now snd_pcm_mmap_begin reports frames == 0
so I can't update the ring buffer anyway.
Third ioctl updates the ring buffer.

What is interesting snd_pcm_forward(pcm,N) always reports 0 or avail
for any N>0 in my case.

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
