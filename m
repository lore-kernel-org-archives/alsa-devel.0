From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 20 Jan 2003 01:25:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m365skjq1j.fsf@grouper.coelacanth.com>
References: <3E2A952E.6060305@boosthardware.com>
	<1042985569.1663.33.camel@satellite.undata.org>
	<3E2AC45F.3070601@boosthardware.com>
	<1042992464.1649.55.camel@satellite.undata.org>
	<3E2AD34D.6070308@boosthardware.com>
	<m3d6mt9is6.fsf@grouper.coelacanth.com>
	<1042978893.1341.108.camel@Godzilla>
	<m3ptqskcay.fsf@grouper.coelacanth.com>
	<1042994069.1162.33.camel@Godzilla>
	<m3bs2ck1o3.fsf@grouper.coelacanth.com>
	<1043006386.1401.60.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1043006386.1401.60.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>>>>> Mark Knecht <markknecht@attbi.com> writes:

  > I can think of my HDSP mixer as a device with 52 inputs and 26
  > outputs. 

In the case of the 9652, you don't have headphone outputs, so you
don't have the Digiface's 27th and 28th outputs.

  > 1) 26 mixer inputs come from the HDSP's physical inputs 
  > - numbered 0-25 in the mixer
  > - called Alsa_pcm:capture_1 - 26 in Jack

Yup.

  > 2) 26 mixer inputs come from the Alsa:playback group
  > - numbered 26-51 in the mixer
  > - called Alsa_pcm:playback_1 - 26 in Jack

Yup.

  > 1) 26 mixer outputs come from the mixer
  > - numbered 0-25 out of the mixer

Yup.

  > By default, the HDSP driver then takes the Alsa_pcm:playback group
  > and hooks them to (more or less) matching output destinations:

Perhaps, but I'm not sure about that.  I always explicitly set up the
HDSP mixer routes.  I just removed all of my ALSA modules, removed the
HDSP Cardbus card, power-cycled the Multiface, and reinstalled
everything; and I had to issue an "amixer cset numid=5 26,0,32768"
command to connect alsa_pcm:playback_1 to Multiface output 1.

  > so that if I connect capture_1 to playback_1 then whatever comes
  > in on the ADAT-1, channel 0 input will get sent back out on
  > ADAT-1, channel 1 output.

You don't connect capture_1 to playback_1, because playback_1 is a
signal coming from ALSA, going into the HDSP mixer.  But you _can_
connect the signal arriving on the ADAT1:1 input (which _also_ drives
ALSA's capture_1 input) to the ADAT1:1 output with an "amixer cset
numid=5 0,0,32768" command.  (But playback_1 isn't routed to the
ADAT1:1 output except by coincidence or a default setting -- playback_1
doesn't have anything to do with your ADAT1:1 input -> ADAT1:1 output
connection.)

  > amixer cset numid=5 0,0,32768
  > amixer cset numid=5 1,1,32768
  > ...
  > amixer cset numid=5 25,25,32768

  > which would route each physical input to each physical output, 1
  > for 1, at a volume of unity gain. (As per Marcus's notes again.)

Yup.

  > What is not at all clear yet is whether a single input can go to
  > multiple outs with different gains. For instance, if I execute:

  > amixer cset numid=5 0,0,10000
  > amixer cset numid=5 0,1,30000

Sure, that works just fine.  I'll run a combined setup like this:

    Monitor submix
    ==============================
    amixer cset numid=5 0,26,20000
    amixer cset numid=5 1,27,20000
    amixer cset numid=5 2,26,15000
    amixer cset numid=5 3,27,15000
    amixer cset numid=5 4,26,10000
    amixer cset numid=5 5,27,10000

    DAT safety recording
    ==============================
    amixer cset numid=5 0,24,16384
    amixer cset numid=5 1,25,16384
    amixer cset numid=5 2,24,12288
    amixer cset numid=5 3,25,12288
    amixer cset numid=5 4,24,8192
    amixer cset numid=5 5,25,8192

The changes I make in the first group (headphones submix) don't have
any effect on the signal being recorded by the DAT, which is set up in
the second group.

  > I am attempting to take physical input 0 and sending it to both
  > the left and right outputs, but at different volumes. Is this
  > legal?

Sure.  Consider RME's description of TotalMix, which is "nothing more"
than a software interface (OK, I'm a hardware guy) to the HDSP mixer:

  - setting up delay-free submixes (headphone mixes)
  - unlimited routing of inputs and outputs (free utilisation, patchbay function)
  - distributing signals to several outputs at a time
  - simultaneous playback of different programs over only one stereo channel
  - mixing of the input signal to the playback signal (complete ASIO Direct Monitoring)
  - integration of external devices (effects etc). in real-time
  - mixdown of three ADAT inputs to one (realizing two additional inputs)

RME calls the HDSP mixer in the Multiface a "720 channel" mixer, and
the one in the Digiface "1456 channels".  (The 9652 would be 1352
channels, because it doesn't have the headphone outputs.)  For the
Multiface, that's [18 hardware input channels + 18 playback channels]
x 20 hardware output channels.  (There are only 18 playback channels
because playback_8-15 aren't used in the Multiface.)

  > In my case, I use Alsa_pcm:playback_1/2 for my main speakers, and
  > playback_3/4 for my headphones. The problem I've been having is that I
  > didn't know how to set the volume on my speakers with no mixer. Using
  > this information, I could execute:

  > amixer cset numid=5 26,0,3000
  > amixer cset numid=5 27,1,3000

  > and now my playback_1/2 should come out of my speakers, but at
  > considerably reduced volumes.

Yup.

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
