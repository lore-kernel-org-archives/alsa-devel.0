From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Tue, 8 Jul 2003 08:58:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030708135821.GA1030@dbz.icequake.net>
References: <20030707205357.GQ5013@dbz.icequake.net> <s5hsmphcmxu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hsmphcmxu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

On Tue, Jul 08, 2003 at 12:50:05PM +0200, Takashi Iwai wrote:
> 
> > One issue is to note, I don't know if this is a problem with the ad1848
> > driver in general or what; if I cat a 11025hz mono 8-bit file to
> > /dev/dsp, the sound comes out verrrrry slllloooowwwllly.   But using
> > aplay, it works fine.
> 
> could you check the parameters in /proc/asound/card0/pcm0p/sub0/*
> during playback via oss?

The results are pasted below -- what is strange is that aplay identifies
the file as 11025Hz but apparently the OSS driver thinks it is 8000Hz
data.

> > I am not sure the best way to test the power managmeent code -- it
> > doesn't crash the machine at least. ;)
> 
> it looks ok - but i guess we need to restore the registers (mixer
> status, etc) too.

You are right -- I just checked the registers before and after flipping
that bit, and it seems they are set to default values afterwards, which
would seem to support the possibility that this is a power management
feature.

The main thing I was wondering about is if some other machine with a
AD1848 goes into D0 for instance, and the suspend function does nothing
(since it is not a thinkpad), is the system still in an ok state as long
as the card's status is not set to D0 when the card is actually not in
D0?  Does that make sense?

---------------------------------------------------------------------

<start of playback>
$ cat /proc/asound/card0/pcm0p/sub0/*
no setup
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: AD1848
name: CS4248
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: OPEN
trigger_time: -1061273892.-1072503897
tstamp      : -1071322800.-1071322416
delay       : -1056799360
avail       : -1056014772
avail_max   : 3747840
-----
hw_ptr      : 0
appl_ptr    : 0
no setup

<little later in playback>
$ cat /proc/asound/card0/pcm0p/sub0/*
access: RW_INTERLEAVED
format: U8
subformat: STD
channels: 1
rate: 8000 (8000/1)
period_size: 4096
buffer_size: 65536
tick_time: 10000
OSS format: U8
OSS channels: 1
OSS rate: 8000
OSS period bytes: 4096
OSS periods: 16
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: AD1848
name: CS4248
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: DRAINING
trigger_time: 1057672530.000584530
tstamp      : 1057672533.000162630
delay       : 8029
avail       : 57507
avail_max   : 61467
-----
hw_ptr      : 20643
appl_ptr    : 28672
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4096
xfer_align: 1
start_threshold: 1
stop_threshold: 65536
silence_threshold: 0
silence_size: 0
boundary: 1073741824



-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
