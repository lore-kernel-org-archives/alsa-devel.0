From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: using external MIDI device to control the computer
Date: Wed, 20 Mar 2002 13:52:15 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NGBBLNODKDFPBFMBBFAFAEDJCEAA.James@superbug.demon.co.uk>
References: <20020320120100.77981.qmail@web21306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020320120100.77981.qmail@web21306.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: fn ln <neplace1@yahoo.ca>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For PCM, alsa has a method to hook the stream, and insert one's own bit of
code thus modifying the PCM audio stream as it passes through alsa-lib to
the alsa-driver.

I don't know if this is possible for MIDI data, but I am sure it could be
implemented in alsa-lib in quite a need way.

Cheers
James



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of fn ln
> Sent: 20 March 2002 12:01
> To: alsa-devel@lists.sourceforge.net
> Subject: [Alsa-devel] using external MIDI device to control the computer
>
>
>
>  Hi,
>
>   I would like to use a digital piano keyboard
> attached to the serial port (MIDI-to-host 38400 bps
> MIDI connection) to generate some events on the
> computer.
>
>   E.g. if I press the two lowest notes at the same
> time, I can move the mouse cursor or switch desktops,
> etc.  I imagine I would have to have a kernel module
> which would implement filtering of certain events and
> passing them to some place, like a pipe that my
> control
> program (perhaps perl) would read and perform
> corresponding actions that I would program it to do.
>
>   Is there currently a way to "insert a MIDI filter"
> into the MIDI stream received from the digital piano ?
> Or at least to say "copy all MIDI events into this
> socket / pipe for pickup by an application" (and that
> application would then recognize these special
> "control" events and would generate the system
> commands
>  / events) ?
>
>  How can I use the piano to control the computer ?
> (while I am recording, or some third app is consuming
> the MIDI stream on its own, and I have no control over
> that app)
>
>  If there currently isn't a way to filter or duplicate
> the incoming MIDI stream, what would be necessary ?
>
> thanks - john
>
>
> ______________________________________________________________________
> File your taxes online! http://taxes.yahoo.ca
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
