From: Paul Davis <pbd@Op.Net>
Subject: Re: using external MIDI device to control the computer
Date: Wed, 20 Mar 2002 02:57:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203201257.HAA29471@renoir.op.net>
References: <20020320120100.77981.qmail@web21306.mail.yahoo.com>
In-Reply-To: Your message of "Wed, 20 Mar 2002 07:01:00 EST."
             <20020320120100.77981.qmail@web21306.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: fn ln <neplace1@yahoo.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>etc.  I imagine I would have to have a kernel module which would
>implement filtering of certain events and passing them to some place,
>like a pipe that my control program (perhaps perl) would read and
>perform corresponding actions that I would program it to do.

not to appear too snobbish, but this is linux, and we don't do stuff
like that in the kernel. 

at this time, there isn't any equivalent of OMS-like filtering for the
ALSA sequencer, but its pretty simple to write a sequencer client that
collects all the data and represents some or all of it at its own
sequencer port(s). you would then connect other applications to the
filter's ports, and see a filtered version of the MIDI stream.

> How can I use the piano to control the computer ?
>(while I am recording, or some third app is consuming
>the MIDI stream on its own, and I have no control over
>that app)

the sequencer can multiplex MIDI data to multiple clients. several
clients can connect to the same sequencer port, and they will all see
the data. i don't know that this scales to very large multiplexing
systems, but it will certainly work fine for a few clients.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
