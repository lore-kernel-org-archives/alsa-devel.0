From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Wed, 25 Feb 2004 09:23:30 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402250921050.3124-100000@studcom.urz.uni-halle.de>
References: <200402250010.AAA06565@liam2.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200402250010.AAA06565@liam2.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Will <walsac2@liam2.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Will wrote:

> Clemens Ladisch <clemens@ladisch.de> wrote:
> >
> >If you get correct output when you run "amidi -p virtual -d" and
> >aconnect your keyboard to that port, then it may be a bug in
> >arecordmidi.  I'll test when I'm at home.
>
> This is what I get:
>
>   $ pmidi -l
>     Port     Client name                       Port name
>     64:0     Rawmidi 0 - Sound Blaster 16 M    Sound Blaster 16 MPU-401

You didn't apply all my patches, or recompile; this name would be
different.

Did you change asequencer.h in both the kernel and alsa-lib?

> playing various notes on the MIDI keyboard gives correct MIDI output in ASCII:
>
>    90 29 4A
>    ...

On my machine, arecordmidi works just fine.


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
