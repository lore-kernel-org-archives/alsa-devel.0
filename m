From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: How to tell how many frames gone to PCM
Date: Mon, 02 May 2005 11:04:36 -0700
Message-ID: <42766BB4.2070500@pianodisc.com>
References: <Pine.HPX.4.33n.0504281011230.16383-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050503020400050002030604"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504281011230.16383-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050503020400050002030604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:
> Steve deRosier wrote:
> 
>>Forgeting the +4/PERIOD_SIZE hack I've got in there for a moment
>>(I must have a culmative off-by-one error somewhere),
> 
> 
> No, the events are usiong the wrong clock.  Real-time scheduling uses
> the system clock instead of the timer source you've set for the queue.
> That is, at every timer interrupt, ALSA checks whether the system time
> has reached the scheduled event time.  OTOH, MIDI ticks are calculated
> using the timer interrupt frequency.
> 

So, even though I tied the MIDI timer source to the pcm timer, if I use real-time events, those events will use the system clock?  I figured the MIDI timer would just be used and the time just calculated via whatever the MIDI timer was doing.

> 
>>Ideas of the PPQ and BPM I should use to match 1 tick to 1 frame?
> 
> 
> I'd use one quarter note per second (tempo = 1000000 microseconds per
> quarter note) so that the sampling frequency can be used directly as
> PPQ (ticks per quarter note).

While waiting for your answer, I decided to keep the tempo the "same" as what I was using, tempo = 500000 so that tempo changes wouldn't need to adjuct the PPQ, so came up with a PPQ = 22050.  This should be equivelent as tempo = 1000000; PPQ = 44100 (which I tried with the same results).  All is fine in my calculation as near as I can tell (PCM data is standard CD of 44100 samples/sec).

BUT...

The MIDI plays WAY too slow.  I don't get it.  I can speed it up clearly by using a larger PPQ or smaller tempo, but I can't seem to do it in any manner that will get my MIDI to line up with my audio.

I notice in /proc/asound/card0/pcm0p/sub0/hw_params gives a tick_time of 1000.  Would that affect anything since I'm triggering the queue time off the pcm?

Including lots of proc data incase there's a clue there I don't know about.

Thanks,
- Steve

--------------050503020400050002030604
Content-Type: text/plain;
 name="opus_alsa.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opus_alsa.txt"

# cat pcm
00-00: VIA 82C686A/B rev50 : VIA 82C686A/B rev50 : playback 1 : capture 1
# cd card0
# ls
codec97#0  id         midi0      pcm0c      pcm0p      via82xx
# cd pcm0p
# ls
info  sub0
# cat info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: VIA 82C686A/B rev50
name: VIA 82C686A/B rev50
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
# cd sub0
# ls
hw_params  info       prealloc   status     sw_params
# cat info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: VIA 82C686A/B rev50
name: VIA 82C686A/B rev50
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
# cat hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 2048
buffer_size: 16384
tick_time: 1000
# cat prealloc
64
# cat status
state: RUNNING
trigger_time: 1115052640.065836000
tstamp      : 1115052699.379423000
delay       : 15388
avail       : 996
avail_max   : 8562
-----
hw_ptr      : 2616292
appl_ptr    : 2631680
# cat sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 1
start_threshold: 8192
stop_threshold: 32768
silence_threshold: 0
silence_size: 0
boundary: 1073741824
# cd ..
# cd ..
# ls
codec97#0  id         midi0      pcm0c      pcm0p      via82xx
# cd ..
# ls
Opus7    card0    card1    cards    devices  pcm      rev50    seq      timers   version
# cd card1
# ls
id     midi0
# cat id
Opus7
# cat midi0
uart16550 MIDI #0

Output 0
  Tx bytes     : 130751
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Output 1
  Tx bytes     : 0
Output 2
  Tx bytes     : 37961
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Input 0
  Rx bytes     : 2688
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 1
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 2
  Rx bytes     : 1751
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
# cat midi0
uart16550 MIDI #0

Output 0
  Tx bytes     : 130795
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Output 1
  Tx bytes     : 0
Output 2
  Tx bytes     : 37961
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Input 0
  Rx bytes     : 2688
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 1
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 2
  Rx bytes     : 1751
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
# cat midi0
uart16550 MIDI #0

Output 0
  Tx bytes     : 131098
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Output 1
  Tx bytes     : 0
Output 2
  Tx bytes     : 37961
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Input 0
  Rx bytes     : 2688
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 1
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
Input 2
  Rx bytes     : 1751
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0
# ls
id     midi0
# cd ..
# ls
Opus7    card0    card1    cards    devices  pcm      rev50    seq      timers   version
# ls -l
lrwxrwxrwx    1 root     root            5 May  2 09:53 Opus7 -> card1
dr-xr-xr-x    5 root     root            0 May  2 09:53 card0
dr-xr-xr-x    2 root     root            0 May  2 09:53 card1
-r--r--r--    1 root     root            0 May  2 09:53 cards
-r--r--r--    1 root     root            0 May  2 09:53 devices
-r--r--r--    1 root     root            0 May  2 09:53 pcm
lrwxrwxrwx    1 root     root            5 May  2 09:53 rev50 -> card0
dr-xr-xr-x    2 root     root            0 May  2 09:53 seq
-r--r--r--    1 root     root            0 May  2 09:53 timers
-r--r--r--    1 root     root            0 May  2 09:53 version
# cd seq
# ls
clients  drivers  queues   timer
# cat timer
Timer for queue 0 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536
Timer for queue 1 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536
Timer for queue 2 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536
Timer for queue 3 : RTC timer
  Period time : 0.000976562
  Skew : 65536 / 65536
Timer for queue 4 : PCM playback 0-0-0
  Period time : 0.046545454
  Skew : 65536 / 65536
# cat queues
queue 0: [Queue-0]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 480
current tempo      : 500000
current BPM        : 120
current time       : 319196.794578970 s
current tick       : 306429118

queue 1: [Queue-1]
owned by client    : 129
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 480
current tempo      : 500000
current BPM        : 120
current time       : 319196.793602408 s
current tick       : 306429117

queue 2: [Queue-2]
owned by client    : 130
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 480
current tempo      : 500000
current BPM        : 120
current time       : 319196.793602408 s
current tick       : 306429117

queue 3: [Queue-3]
owned by client    : 131
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 480
current tempo      : 500000
current BPM        : 120
current time       : 319196.792625846 s
current tick       : 306429117

queue 4: [Queue-4]
owned by client    : 132
lock status        : Locked
queued time events : 0
queued tick events : 14
timer state        : Running
timer PPQ          : 44100
current tempo      : 1000000
current BPM        : 60
current time       : 2.141090884 s
current tick       : 94425

# ls
clients  drivers  queues   timer
# cat drivers
snd-seq-midi,loaded,2
# cat clients
Client info
  cur  clients : 9
  peak clients : 12
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
Client  62 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
Client  64 : "VIA 82C686A/B rev50 MIDI - Rawmidi 0" [Kernel]
  Port   0 : "VIA 82C686A/B rev50 MIDI" (RWeX)
Client  72 : "uart16550 MIDI #0 - Rawmidi 1" [Kernel]
  Port   0 : "uart16550 MIDI #0-0" (RWeX)
    Connecting To: 129:0[t:1]
    Connected From: 131:0
  Port   1 : "uart16550 MIDI #0-1" (RWeX)
    Connecting To: 128:0[r:0]
  Port   2 : "uart16550 MIDI #0-2" (RWeX)
    Connecting To: 129:0
    Connected From: 130:0
Client 128 : "Client-128" [User]
  Port   0 : "In" (-We-)
    Connected From: 72:1[r:0], 132:0
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 4
    Alloc success      : 1380
    Alloc failures     : 0
Client 129 : "Client-129" [User]
  Port   0 : "In" (-We-)
    Connected From: 72:0[t:1], 72:2
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 2
    Alloc success      : 23
    Alloc failures     : 0
Client 130 : "Client-130" [User]
  Port   0 : "Out" (R-e-)
    Connecting To: 72:2
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 32
    Alloc success      : 64
    Alloc failures     : 0
Client 131 : "Client-131" [User]
  Port   0 : "Out" (R-e-)
    Connecting To: 72:0
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 4
    Alloc success      : 1373
    Alloc failures     : 0
Client 132 : "Client-132" [User]
  Port   0 : "Out" (R-e-)
    Connecting To: 128:0
  Output pool :
    Pool size          : 500
    Cells in use       : 66
    Peak cells in use  : 66
    Alloc success      : 128
    Alloc failures     : 0

--------------050503020400050002030604--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
