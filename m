From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Sequencer Input
Date: Thu, 19 Dec 2002 09:13:18 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212190909130.1354-100000@studcom.urz.uni-halle.de>
References: <20021218000609.GB12303@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021218000609.GB12303@bhv1.adelphia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Brian Victor wrote:
> I'm using a MidiSport 1x1 and devfs.  The modules are loading, pmidi is
> displaying the MidiSport and playing MIDI files through it just fine, so
> I presume output through /dev/snd/seq is working.  cat /dev/snd/midiC0D0
> displays approrpriate "garbage" characters, but cat /dev/snd/seq does
> nothing,

This is OK, /dev/snd/seq cannot be accessed as a byte stream, unlike some
other devices. You have to use a program using the ALSA sequencer API to
test sequencer input.

> and the seqdemo.c sample just sits there.

seqdemo.c prints only those events sent to its port. Use aconnect to
connect the 1x1 port to the seqdemo port.


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
