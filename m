From: Mark Knecht <markknecht@attbi.com>
Subject: HDSP 9652 MIDI - A timing disaster?
Date: 11 Jan 2003 07:49:16 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1042300157.1986.15.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   I asked about this two weeks ago but got no responses. I'm hoping
this time I hear something back from other owners of the same hardware.

   I recently purchased an RME HDSP 9652 card. The card is working fine
for audio, but the MIDI interface is a timing disaster. The interface
works, but won't keep time. A 2 minute song is Rosegarden takes abut
2:45 to play every time. You can hear how the HDSP isn't delivering
closely spaced MIDI events together, but is sort of smearing them out.

   My machine is set up using the PlanetCCRMA system. According to
Synaptic my Alsa driver is from CVS:20021216. Jack is 0.44. This machine
works just fine with the MidiMan 2x2 interface. No timing problems at
all.

   Has anyone else purchased this card? Used the MIDI interface on this
card? Gotten better results with this card?

   Can anyone suggest how I could go about fixing this myself? I'm not a
programmer, so really hacking the code is doubtful, but this driver is
acting like there is just a basic mistake somewhere. Possibly I could
find it if I knew where to look.

   I hope someone will respond to this email so we can get something
going to get this fixed. I really need this interface to operate soon.

Thanks in advance,
Mark

   





-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
