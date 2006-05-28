From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation
	for ati-ixp chipset.
Date: Sun, 28 May 2006 03:20:06 +0200
Message-ID: <52fd8a2e42a24d5cee3d01d01e2daa05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3B43171
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 03:20:07 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2147> 
======================================================================
Reported By:                Gene Heskett
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2147
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC5, uptodate
Kernel Version:             2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 03:52 CEST
Last Modified:              05-28-2006 03:20 CEST
======================================================================
Summary:                    lack of full duplex operation for ati-ixp chipset.
Description: 
skype, ekiga, audacity, and generally any program that needs to both
transmit and receive, using isolated paths, fails in playback when
recording.  In skype, I sound great at the far end, but reception may or
may not work, with emphasis on the not.  What I hear in the phones, or in
the speakers, sounds like what you would get if you took a sentence of
spoken words, break it up into say 5ms pieces, and play them at maybe 10
of these little snippets per second, so that the resultant sound is broken
up to the point of no comprehension, and stretched in time by a
considerable amount.

In audacity, simultanious playback, or play one track while recording
another, likewise fails in that only very short snippets of the played
track are output to the phones or speakers.

Likewise, ekiga suffers from this same effect, I'm told I sound great on
teh other end, but I can't hear more than half a word occasionally.
======================================================================

----------------------------------------------------------------------
 Gene Heskett - 05-28-06 03:08 
----------------------------------------------------------------------
Ok, now I have a couple of days to play with this.  To quote you:
"Apparently you're trying to do something special."

I suppose thats in the eye of the beholder, but I do not consider running
skype or its ilk too terribly special.  In my eye, what you are asking me
to do is the special stuff.

>From a few hours of screwing with this last week, its known that
speaker-test runs ok regardless of the starting order.  However if
speaker-test is the first user of the audio system started, then nothing
else can access  in the headset now, so lets see if your example "arecord
-vv -fcd foo.wav" works, and yes it does.  However, no volume control
appeared, and my talking, with the headset mouthpiece only half an inch to
one side, looked as if it was overloading arecord.  However, stopping the
speaker-test, and "aplay foo.wav" also works.
Now, start the recording first...  And thats working also.

So that, according to your judgement, means its working.  So why can't I
make it work in the real world?  For skype or ekiga.

FWIW, when I start arecord, I get this on the terminal screen but no
volume control appears:

[root@diablo libzrtp-0.2.0]# arecord -vv -fcd foo.wav
Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:default)
Hardware PCM card 0 'ATI IXP' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 85333
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 4096
  xfer_align   : 4096
  start_threshold  : 1
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
##+                                               | 03%%
Aborted by signal Interrupt...

Does anyone have a recipe for an .asoundrc that will stop the above error,
or make it work for skype etc?

Audacity can record ok, PROVIDED it is the first thing started, if I do
the speaker-test thing, then start audacity, then audacity is locked away
from the device, this will also occur if I stop the audacity recording
while speaker-test is running, and then attempt to restart a new
recording.

Is audacity an oss appliction?  In which case what do we replace it with
thats alsa compliant?

-- 
Cheers, Gene

----------------------------------------------------------------------
 Gene Heskett - 05-28-06 03:20 
----------------------------------------------------------------------
I'm sorry, that added note got badly hacked and parts of it will not make a
lot of sense.  This lappy has a touch pad that I cannot seem to disable,
and if a thumb gets too close to it (it doesn't have to actually touch the
sonofabitch), it will jump to someplace else on the screen and highlight a
few lines of text, which will of course be deleted on the next keystroke.

Its such a pain in the ass that I'm tempted to go get a usb keyboard and
see if I can make it work because this is frustrating in the maximus.

That however has little or nothing to do with my audio problem, and thats
a lack of full duplex operation IN THE REAL WORLD...

-- 
Cheers, Gene

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:52 Gene Heskett   New Issue                                    
05-23-06 03:52 Gene Heskett   Distribution              => FC5, uptodate   
05-23-06 03:52 Gene Heskett   Kernel Version            => 2.6.16-1.2111_FC5
05-23-06 15:01 tiwai          Note Added: 0009934                          
05-23-06 16:46 Gene Heskett   Note Added: 0009938                          
05-23-06 17:24 tiwai          Note Added: 0009941                          
05-23-06 18:07 Gene Heskett   Note Added: 0009943                          
05-23-06 19:14 tiwai          Note Added: 0009947                          
05-28-06 03:08 Gene Heskett   Note Added: 0009985                          
05-28-06 03:20 Gene Heskett   Note Added: 0009986                          
======================================================================
