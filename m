From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: [MusE] Syncing muse with ardour
Date: 19 Jun 2003 02:18:51 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055953131.10900.76.camel@littlewolf2.littlewolf>
References: <3EEFA698.6030800@vrweb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EEFA698.6030800@vrweb.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Buechler <martin.buechler@vrweb.de>
Cc: ardour-dev <ardour-dev@lists.sourceforge.net>, Ardour-users <ardour-users@lists.sourceforge.net>, Alsa-dev <alsa-devel@lists.sourceforge.net>, ws@seh.de
List-Id: alsa-devel@alsa-project.org

(firstly like to apologise to all on multi lists for cross posting but I
don't think this is necessarily just a MusE problem, it could be either
MusE, ardour or alsa and needs to be investigated further from all
angles) 

Hi All

I've just done some testing of various scenarios regarding syncing MusE
and Ardour and external devices.. via a MOTU Midi Timepiece AV (as the
code for this is not 100% solid I will redo this test with the intel8x0
MIDI driver tomorrow at around this time.. it's too late now and I'm
back at work, I can't have the late nights I've been having lately) 

Versions 

MusE 0.60 
Ardour beta1a tarball

(also no xruns were observed in this testing period) 

After some testing I suspect this may either be related to the way these
two softwares handle the virmidi device.. or how alsa handles midi
devices in general, or possibly the way MusE sends MIDI sync message. I
alos gather both from discussion and testing that the MIDI
implementation for sync in Ardour is not complete. 

NOTE: MTC/SMPTE  can't be tested reliably on my system as mtpav won't
lock sync with alsa..  but MMC and MIDI clock work well

Scenario 1 (mtpav/muse)
Syncing MusE to external MIDI device...  very succesful, MusE is
responding well to MMC and MIDI clock signal.. moves with transport of
external device, keeps bar sync accurate. 

Scenario 2 (muse/mtpav)
Syncing external device to MusE .. reasonable success.. External device
recognises MIDI start stop, restart.. but external device doesn't sync
with transport movements on MusE 

Scenario 3  (mtpav/ardour) 
Syncing Ardour to external MIDI device... moderate  success  a little
bit flaky at times,. missing a stop signals quite often but generally
working OK. Ardour sees MIDI transport messages including moving bars
forward and back.. 

It seems that the ability to see a stop signal and the ability to follow
the external transport are related (this is hard to describe) If I start
ardour and it can see a stop signal it does so consistently until it is
shut down, in this case it also recognises transport.. 

If it doesn't recognise the stop signal it won't do so until another
restart.. (no change in conditions). There is no way of setting up the
conditions  to guarantee that ardour sees or doesn't see the stop and
transport moves.. (also transport moves are not in sync as ardour
doesn't recognise MIDI clock, although this is expecte behaviour as this
has not been implemetned as yet)  


Scenario 4 (ardour/mtpav)  
Syncing External device to Ardour.. failed entirely.. a midi message was
seen to be passed through the mtpav but the external sequencer did not
register or understand this message as it had done with MusE.  


Scenario 5 (ardour(virmidi)/muse)


1. (external sequencer still was sending MIDI clock on first round of
tests) ....MusE responded unconventionally to messages sent by ardour...
(ardour set as master sending MTC and MMC)   MusE would start when the
"go to start" button was pressed.. and stop on stop but only after play
had been pressed on ardour .. it would not start on "play"


(2nd round external sequencer off) .. Nothing was received by MusE.. 
  
Scenario 6 (muse(virmidi)/ardour) 
Syncing ardour to MusE.. failed.. 
Even with all tracks set to broadcast via virmidi.. ardour did not
respond.. 

Scenario 7 
external (mtpav)-> MusE ->(virmidi)  ardour.. 
MusE would sync to external but ardour would not respond to MusE even
when no mtpav device was specified in a track (but enabled as a port) ..
MusE would still respond to the external device..

Scenario 8 
external  (mtpav) ->ardour -> MusE 

Scenario 9 
		    - ardour 	
external (mtpav) -
		    - MusE

setting up both apps to listen to mtpav port 1 (/dev/snd/midiC2D0)

Success  MusE only..   MusE again was responding to the external device
.. ardour did not respond.. 


A question for MusE/Werner... does MusE send received sync signals
through... (the sync options menu seems to indicate this and this is
desirable.. if it can be mapped to specific devices i.e. pass sync in
from mtpav to sync out virmidi, although this option is definitely not
presently apparent) 

So my results. show (with mtpav driver will test with intel8x0 2moro
combination on weekend) that MusE sends and receives sync from external
devices reliably.. Ardour receives MMC sync from external devices with
glitches.. but doesn't send reliably.. 

Neither sends nor receives sync via virmidi driver.. 

Hence the (or maybe my) ideal situation MusE synching with external
sequencer/transport and sending sync to ardour does not 

external --> MusE --> Ardour  Failed.. 

I hope this helps.. 

Will send more results soon.. especially as I don't trust the mtpav
driver 100%.. (might install old ens1371 for reliable driver testing) 

cheers

Allan

 





On Wed, 2003-06-18 at 09:39, Martin Buechler wrote: 
> Hi at muse,
> 
>   ardour-1.0 will not include a sequencer (AFAIK), and muse seems to be 
> (I know, even more than) the complementary part to handle midi related 
> recordings/overdubs. I thought, that all I would need is midi machine 
> control with ardour as the master, muse as the slave.
> 
>   What I tried was: Directing  ardour's - current is 1.0beta1-c - mmc to 
> a virtual midi interface provided by the ALSA snd-virmidi module and 
> driving muse as slave accepting mtc/midi clock/mmc with Id 127 and all 
> ports.(Hmm, Whats the use of this Id anyway?)  Selecting ardour's MTC 
> generation seems not to change the behaviour of muse/ardour. Selecting 
> the third ardour MIDI option, which is called 'MMC Control' in ardour's 
> options panel, crashes ardour instantly! That may be part of the 
> problem, I guess...
> 
>   Additionally, sync generation was turned off in muse. The transport 
> grays out, and when I start ardour rolling, muse does exactly nothing. 
> But, when I switch off/on the sync button in the transport panel of 
> muse, then I am able to control stop/begin/end whithin ardour! Great, 
> but it 's quite useless, when muse does not *start* with ardout, isn't it?
> 
> Here's some output of muse -mMDs:
> 
> ardour:
> ->Goto end
> (another thing: the bar counts seems to be actually not the same in muse 
> and ardour)
> --
> MidiInput: port:1 chan:193 port:1 chan:192 type:0xf0 a=8 b=0 data len 11
> mmcInput: n:11 06 44 06 01
> MMC: 156.560000 120238 seek 00:02:36:14:00
> MidiInput: port:1 chan:193 port:1 chan:192 type:0xf0 a=8 b=0 data len 4
> mmcInput: n:4 06 01 06 01
>    MMC: STOP
> --
> ->Goto begin:
> --
> MidiInput: port:1 chan:122 port:1 chan:121 type:0xf0 a=8 b=0 data len 11
> mmcInput: n:11 06 44 06 01
> MMC: 0.000000 0 seek 00:00:00:00:00
> MidiInput: port:1 chan:122 port:1 chan:121 type:0xf0 a=8 b=0 data len 4
> mmcInput: n:4 06 01 06 01
>    MMC: STOP
> --
> 
> -> Here I started ardour, but nothing happens..
> 
> Stop:
> --
> MidiInput: port:1 chan:180 port:1 chan:179 type:0xf0 a=8 b=0 data len 4
> mmcInput: n:4 06 01 00 00
>    MMC: STOP
> --
> 
> How did you get syncing done, maybe even with ardour? Do I expect too much?
> 
> Thanks for reading.
> 
> Martin
> 
-- 
Allan Klinbail <allank@labyrinth.net.au>



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
