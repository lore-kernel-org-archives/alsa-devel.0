From: Paul Davis <pbd@Op.Net>
Subject: Re: using external MIDI device to control the computer
Date: Thu, 21 Mar 2002 07:01:32 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203211201.HAA13010@renoir.op.net>
References: <20020321064256.83273.qmail@web21302.mail.yahoo.com>
In-Reply-To: Your message of "Thu, 21 Mar 2002 01:42:56 EST."
             <20020321064256.83273.qmail@web21302.mail.yahoo.com>
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

> a sequencer client ? as a userspace program ? How
>could it then get the (filtered) data back for the
>MIDI app into /dev/midi ? I didn't think there was a
>way for a userspace program to feed "incoming" data
>into /dev/midi, and therefore I thought that it would
>have to be a kernel module, not a userspace pgm.

the sequencer API isn't structured around /dev/midi, its structured
around sequencer ports. clients have their own ports which they
connect to other ports. all the raw midi devices automatically become
clients with ports (which correspond to the h/w they control) when the
sequencer module is loaded, so you can always send/receive data to
them. a client can be a user space program or a kernel space
entity. any number of clients can be connected to a port.

>How can "several clients connect to the same sequencer
>port " so they all see the data ?

as i said, /dev/midi isn't the sequencer, its the raw MIDI device, and
there isn't a way to multiplex access to it except via the sequencer.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
