From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001187]: Gain control for M-Audio Revolution (and other ice1724 cards) needed
Date: Mon, 20 Jun 2005 01:05:20 +0200
Message-ID: <7fcbacf67236ffee575b47bdb16ec32b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74BC91CE
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2005 01:05:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1187> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1187
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Mandriva
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-12-2005 15:51 CEST
Last Modified:              06-20-2005 01:05 CEST
======================================================================
Summary:                    Gain control for M-Audio Revolution (and other
ice1724 cards) needed
Description: 
Hello,

this is in a sense continuation of

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1164
.

Yes, I remember Takashi's statement that the ADC chip on the card does
not
have gain control, and I checked the ADC specs and it's indeed so.

However, this doesn't mean the functionality can not be implemented.

I believe it should be implemented for at least two reasons:

1) Windows driver has it;
2) Applications like "Skype" need it to implement AGC (automatic gain
control)
in software.

Regarding 2) - I clearly hear while talking through "Skype" that gain on
the other party's side increases (room noise pickup is becoming more and
more
evident) when the other party makes a pause in conversation.


Regarding 1) - in

http://m-audio.com/images/en/manuals/Revo71-Manual-EN.pdf

file on page number 14, under "Line and Mic In" one can read:

"
You can set the INPUT LEVEL of the Line and Mic inputs on the Input/Other
tab of th
Revolution 7.1 control panel. See the Control Panel section for more
details.
"
(capitalization by me).


On page number 22 of the same file, under "Input/Other Tab":

"
The Input/Other tab controls the INPUT LEVELS and sampling frequency of
the
Revolution. You don't need to worry about the settings on this page unless
you're
recording audio with the Revolution.
Link Stereo Input Levels - The Input/Other tab controls the INPUT LEVELS
and
sampling frequency of the Revolution. You don't need to worry about the
settings
on this page unless you're recording audio with the Revolution.
"
(capitalization by me).


On page number 25 under "Recording":

"
The Revolution 7.1 includes a pair of audio inputs for recording. You can
set the
INPUT LEVEL of the inputs by launching the Revolution 7.1 control panel,
selecting
the Input/Other tab, and changing the level on that screen. If your
recording
application doesn't see audio from the Revolution's inputs, check that
program's
audio preferences, check your cable connections, or review the Software
Setup
chapter for potential problems. Go to the Windows Control panel and open
Sounds and Multimedia icon. The Revolution 7.1 features both Line and Mic
inputs for the best performance with your input source. The Revolution
7.1
records at sampling rates up to and including 96kHz.
"
(capitalization by me).


The "Input/Other" tab in its non-selected form can be seen on the picture
on page 20 - to see it more clearly I had to choose 400% zoom in 'xpdf'.



Regarding feasibility.

First of all, gain can be changed by multiplying the code by the gain
value.

If I remember correctly, in ALSA the card outputs audio data in 32 bit
format,
of the 32 bits only 24 bits are significant because that's what the ADC
produces, so we have 8 spare bits, which means 256 times, or about 48dB
gain
control without even losing precision.


General note on priority of implementing the feature.

Though I believe the feature is needed, and not only for Revolution 7.1,
but
also for other ICE1724-based cards, please understand the following:

*** I still have no capture with my Revolution 7.1 (issue
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001096) ***
.

Since I'm not getting it work, I've been trying to use ALSA utilities
('amixer',
'alsamixer', 'aoss') - "trial and error" approach -  to make it work, and
have
found other problems on the way.

Resolution of these other problem, including introduction of gain
control,
will not solve my main problem - lack of capture.


I would appreciate getting an answer to the question in

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 :

"
Maybe my previous question does not contain enough details.

Here is the rephrased question:

Running 'amixer' with this command line

amixer cget numid=<number>

, where <number is in 5..12 range, I see output like this:

"
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item 0 'PCM Out'
  ; Item 0000001 'H/W In 0'
  ; Item 0000002 'H/W In 1'
  ; Item 0000003 'IEC958 In L'
  ; Item 0000004 'IEC958 In R'
  : values=0
".

Can any of these controls be related to enabling capture ?

Thanks,
  Sergei.
".

Or, to be more precise, getting an answer to the question in general:
"How
to enable capture in M-Audio Revolution 7.1 ?".

Thanks,
  Sergei.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001096 no capture with M-Audio Revolution 7.1
======================================================================

----------------------------------------------------------------------
 tiwai - 06-15-05 15:26 
----------------------------------------------------------------------
Clearly this is the problem of application.  Why the _kernel_ driver
bothers to implement an emulation _on software_ which doesn't exist?
Note that if Skype is running on ALSA, it'd be more easily solved.

The input selection of line-in and mic is unknown thing - i.e. we have no
technical information about this feature at all.  Sorry, impossible to
ipmlement now.  For improving this, please ask M-Audio to provide this
particular information.

----------------------------------------------------------------------
 sst4 - 06-20-05 01:05 
----------------------------------------------------------------------
Regarding

"
Why the _kernel_ driver bothers to implement an emulation _on software_
which doesn't exist?
"

- I do not know what's the best way to do this.

Windows "package" (driver + GUI) has it, so ALSA should have it too it
wants
to meaningfully compete with Windows.

By the way, probably capture stream is routed through DSP of Envy24HT
chip,
and maybe DSP is capable of doing the required multiplication by gain
value ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-05 15:51 sst4           New Issue                                    
06-12-05 15:51 sst4           Distribution              => Mandriva        
06-12-05 15:51 sst4           Kernel Version            => 2.6.11          
06-15-05 15:26 tiwai          Note Added: 0005032                          
06-16-05 14:59 perex          Relationship added       related to 0001096  
06-20-05 01:05 sst4           Note Added: 0005091                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
