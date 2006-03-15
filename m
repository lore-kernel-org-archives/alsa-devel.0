From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001928]: Only Problems with Surround Sound
Date: Wed, 15 Mar 2006 23:02:50 +0100
Message-ID: <df1be6d0d843f52c907be2f97b7b09a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 42CE2203
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 23:02:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1928> 
======================================================================
Reported By:                the-me
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1928
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sid
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-15-2006 22:02 CET
Last Modified:              03-15-2006 23:02 CET
======================================================================
Summary:                    Only Problems with Surround Sound
Description: 
Hi.
I've got a big problem ( like many other users of many other soundcards ).
My Surroundsound didn't work!
I've got the Terratec Aureon 5.1 Fun soundcard. At alsamixer, I haven't
got any LFE or Center Options ( why? there stands in the topic *MC6 ( for
6 channels! ) ).
Now I tried it with a .asoundrc. Result:
Now my Rear / Front / Center worked correctly at listening to mp3s, the
subwoofer ( lfe ) gives also high sound out, not only deep!!! thats a big
problem.

I tried it with the following .asoundrc =>
http://www.linux-development.org/nopaste/?800

now I found an entry at an wiki of alsa.opensrc.org , which contains
following:

---------------
Custom Routing of Signals to Surround Outputs

With a little .asoundrc hackery, you can easily route signals around any
way you like. See for example FAQ028 for an example of how to play a
stereo signal over booth front and rear speakers simultaneously. The
example can easily be adapted to suit your needs. FAQ028 tells us how to
route our "normal" stereo signals to 4 or 5 speakers. It would be nice to
process the signal for the subwoofer with a lowpass filter. Thats's where
the LADSPA plugins come in handy:

pcm.lowpass {
type ladspa
slave.pcm ...
path "/usr/lib/ladspa"
plugins [ {
label lpf
input {
controls [ 50 ]
}
} ]
}

This filter will cut off everything above 50 Hz. Only problem: How do I
send only one channel (a mixture of right and left channel) through this
filter? And where do I send the filtered signal? I have tried this setup:

# move channel 0 to channel 2
pcm.move0to2 {
type route
slave.pcm 3to6
slave.channels 3
ttable.0.2 1
}
# 3to6 has 3 input and 6 output channels
# the stereo signal is on ch. 0 and 1
# ch.0 is copied to 0 and 2 (front and rear)
# ch.1 is copied to 1 and 3 (front and rear)
# ch.0 and ch.1 will is mixed to ch.4 (center)
# ch.2 is routed to ch.5 (subwoofer)
pcm.3to6 {
type route
slave.pcm "surround51"
slave.channels 6
ttable.0.0 1
ttable.1.1 1
ttable.0.2 1
ttable.1.3 1
ttable.0.4 0.5
ttable.1.4 0.5
ttable.2.5 1
}

This seems to work from the lowpass filter to the output (I have tried
aplay -D plug:lowpass sound.wav). But still the question - How to I get
the data of one channel to the lowpass filter?
---------------

my question, how can I set up this lowpassfilter only for my LFE channel??
I need it!

mfg Patrick
======================================================================

----------------------------------------------------------------------
 the-me - 03-15-06 22:55 
----------------------------------------------------------------------
hmm, you can see this like a feature request.
an alsa option to enable this in alsamixer will be good.

but do you have any idea?

----------------------------------------------------------------------
 rlrevell - 03-15-06 23:02 
----------------------------------------------------------------------
No, sorry, I don't.  You should be able to find a sample .asoundrc for 5.1
upmixing with low pass filter for the LFE on the net though.

If it was easy to enable this by default it would be done already.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 22:02 the-me         New Issue                                    
03-15-06 22:02 the-me         Distribution              => Debian Sid      
03-15-06 22:02 the-me         Kernel Version            => 2.6.15.6        
03-15-06 22:24 rlrevell       Note Added: 0008575                          
03-15-06 22:55 the-me         Note Added: 0008576                          
03-15-06 23:02 rlrevell       Note Added: 0008577                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
