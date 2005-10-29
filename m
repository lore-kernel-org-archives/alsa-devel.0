From: Rick Wright <riwright@vt.edu>
Subject: emu10k1 multichannel issue/observation
Date: Fri, 28 Oct 2005 21:09:43 -0400
Message-ID: <4362CBD7.8080606@vt.edu>
References: <434E7646.3000507@poeticstudios.com> <5bdc1c8b0510221502v28a2cbe0ybfe049be2f34e186@mail.gmail.com> <200510230053.44479.Martin.Wohlleben@gmx.de> <5bdc1c8b0510221655r4d28430fr7b80f5403d8daaa4@mail.gmail.com> <435AF023.70903@woh.rr.com> <5bdc1c8b0510221957s278a28a7n8ead2de1e0760cf6@mail.gmail.com> <435B74E9.20308@woh.rr.com> <20051023180312.GA4544@mobilat.informatik.uni-bremen.de> <5bdc1c8b0510231123h5ed64b38nd178ce9dfcb13f87@mail.gmail.com> <1130097599.11980.54.camel@mindpipe> <5bdc1c8b0510231318j4e9db7b0x1106e9b240329249@mail.gmail.com> <435CFC95.6000703@vt.edu> <1130170444.16563.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130170444.16563.22.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Lee,

I've been using your multichannel patch (actually mainstream now..) to
this driver for several months and it works great.  I was using a
somewhat old (~2 yrs now) version of the Audigy2 ZS Platinum Pro card
w/external chassis.  One thing I never got working was the 7.1 side
channels.  I was never able to see/turn on Side Ch sliders in AlsaMixer
and could never find a playback port(s) to get sound out.  These
channels just didn't seem supported.

Fast-forward to about a month ago and I built another machine and bought
another identical Audigy2 ZS Platinum Pro sound card w/chassis and the
AlsaMixer sliders for the side channels (driver support?) appeared
immediately and I have verified that pcm_playbacks 15 & 16 are the L/R
Side channels, respectively.  As a test, I swapped the sound cards
between two identical machines and the sliders followed the new card.
Appearing where they never had before and disappearing from the machine
originally hosting the new card.

My questions are:
1) Was there an early version(s) of this card where the side channels
aren't supported by the ALSA driver?
2) Could this be made to work?
3) If so, what info is needed and who needs it?



Additionally, at some point in recent time, there is a minor new problem 
where upon initial boot (I think, but can't swear this is 100% 
reproducable) there is low level noise on all outputs.  The fix is to 
unplug/replug the firewire-ish cable that connects the external chassis 
to the PCI card.  This always eliminates the static.  Could this be a 
problem with the card's initialization?



Thanks,
Rick





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
