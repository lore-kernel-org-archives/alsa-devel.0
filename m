From: Mark Knecht <markknecht@attbi.com>
Subject: HDSP 9652 MIDI IN - stuck notes
Date: 26 Feb 2003 20:47:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046321261.2626.28.camel@Godzilla>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-VP45EI3I1Ri9OwDwt2dI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-VP45EI3I1Ri9OwDwt2dI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
   I've had a miserable stuck note problem with Alsa MIDI for a while,
so I finally sat down this evening to try and determine where the
problem was coming from, and it appears to be the HDSP 9652 MIDI input.

   My system has two 2-port MIDI interfaces, the HDSP 9652 (Alsa MIDI
64:0 & 64:32) and a MidiSport 2x2 (Alsa MIDI 72:0 & 72:1) I am using
three external hardware synths on different ports (Alsa 64:0, 72:0 and
72:1) and additionally I ran a copy each of the Linux synths ZynAddSubFx
(Alsa 130:0) and amSynth (Alsa 128:0) at the same time. (I.e. - 5 synths
in parallel, all being driven by a single MIDI input.)

   To do the tests, I use kaconnect and aconnect to build routing in the
MIDI stack to connect a single input to all outputs, which looks like
the attachment when I attach all outputs to the MidiSport Port A input.
In this configuration I can play continually, basically overdriving the
whole system with lots of MIDI events, including controllers and sustain
pedal, and I have no problems. I can do this for at least 15 minutes
with no problem on any of the synths.

   If I then change my keyboard to drive the HDSP 9652 input 1 (Alsa
64:0) and change the connections internally to drive all of outputs, I
get stuck notes pretty much immediately. It seems a bit worse with the
sustain pedal, but does not seem to be effected at all by controllers.
It is heavily effected by the MIDI note density. If I hit only one or
two notes, I'm not likely to get it, but using the sustain pedal I can
create the problem in under a minute.

   To be sure it's the input and not the outputs (as much as I can be) I
have external synths attached to the Alsa outputs on 64:0, 72:0 and
72:1. When I get a stuck note, I seem to get it on both internal soft
synths and all three external hardware synths at the same time. For this
reason I deduce that it is the HDSP input that is not clearing out
whatever event queue that holds this stuff and somehow the note never
shuts off.

   I'll be happy to try any other tests anyone wants me to look into.

   I'd be curious to know if this is a problem on any of the other RME
products that have MIDI or whether it's specifically a HDSP 9652 issue.
Also, have any other HDSP 9652 owners seen this?

   Please let me know what I might be able to do to help further get
this solved. Knowing now that the MidiSport doesn't have a problem, I
can just use it and for me that's fine. However, for others that might
be depending on the HDSP 9652 as a primary interface this would not be
acceptable.

Thanks,
Mark



--=-VP45EI3I1Ri9OwDwt2dI
Content-Disposition: attachment; filename=snapshot1.png
Content-Type: image/png; name=snapshot1.png
Content-Transfer-Encoding: base64

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
SUVORK5CYII=

--=-VP45EI3I1Ri9OwDwt2dI--



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
