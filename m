From: Ricardo Colon <rcolon@andrew.cmu.edu>
Subject: Re: Rawmidi bug or missed feature?
Date: Fri, 1 Mar 2002 09:58:52 -0500 (EST)
Message-ID: <Pine.GSO.4.43L-024.0203010950080.2347-100000@unix14.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203011345.IAA12541@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: Peter Enderborg <pme@ufh.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It's not a bug or missing feature.

You're talking about opening a midi stream that is currently "running
status". Unfortunately, there's no way around it. I don't think it's
really possible to even guess what that previous status byte might have
been. So really you can't do anything until you receive the next status
byte.

I think this is part of the reason why MIDI programs give 4
metronome clicks before allowing you to record. So that they can sync with
the hardware.





On Fri, 1 Mar 2002, Paul Davis wrote:

> >I have a program that read's from a raw midi device. In midi there
> >are some simple compression.  It is assumed that if the data flow is
> >correct, and the data should be interpreted as paramaters to previus
> >command if it's not a new command. But when I open a raw midi stream
> >I can get in to the stream without having the "previus" command. Is
> >there any way to do a query or reset the stream so I can get that
> >command? If it's only one midi channel sending the same type of
> >command it will never get in to sync!
>
> raw MIDI means ***RAW*** MIDI. there is no parsing, no state, no
> history, no automatic reset. you just read and write a stream of
> bytes.
>
> it sounds as if you should issue a full MIDI reset sequence when you
> open the device (all notes off on every channel, reset all controllers
> to a default value, restore all programs to a known state, etc.)
>
> --p
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
