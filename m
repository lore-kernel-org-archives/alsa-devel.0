From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: HDSP 9652 MIDI - A timing disaster?
Date: Mon, 13 Jan 2003 10:04:23 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301130954070.4019-100000@studcom.urz.uni-halle.de>
References: <1042300157.1986.15.camel@Godzilla>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1042300157.1986.15.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-List <linux-audio-user@music.columbia.edu>, Alsa-Devel <alsa-devel@lists.sourceforge.net>, Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
>    I recently purchased an RME HDSP 9652 card. The card is working fine
> for audio, but the MIDI interface is a timing disaster. The interface
> works, but won't keep time. A 2 minute song is Rosegarden takes abut
> 2:45 to play every time. You can hear how the HDSP isn't delivering
> closely spaced MIDI events together, but is sort of smearing them out.

The hdsp driver doesn't send more than one MIDI byte per timer tick.
IMHO it should be modified to send in a loop until the FIFO is full
(however, I don't know if the HDSP has a FIFO at all). And it should start
sending in output_trigger() instead of delaying it to the next timer tick.


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
