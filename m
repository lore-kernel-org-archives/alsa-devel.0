From: fn ln <neplace1@yahoo.ca>
Subject: Re: using external MIDI device to control the computer
Date: Thu, 21 Mar 2002 01:42:56 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020321064256.83273.qmail@web21302.mail.yahoo.com>
References: <200203201257.HAA29471@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200203201257.HAA29471@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--- Paul Davis <pbd@Op.Net> wrote:
> >etc.  I imagine I would have to have a kernel
module which would
> >implement filtering of certain events and passing
them to some place,
> >like a pipe that my control program (perhaps perl) 
would read and
> >perform corresponding actions that I would program
> it to do.
> 
> not to appear too snobbish, but this is linux, and
> we don't do stuff like that in the kernel. 

  :-)


> at this time, there isn't any equivalent of OMS-like
 filtering for the
> ALSA sequencer, but its pretty simple to write a
> sequencer client that collects all the data and
represents some or all of
> it at its own sequencer port(s). you would then
connect other
> applications to the filter's ports, and see a
filtered version of the
> MIDI stream.

 a sequencer client ? as a userspace program ? How
could it then get the (filtered) data back for the
MIDI app into /dev/midi ? I didn't think there was a
way for a userspace program to feed "incoming" data
into /dev/midi, and therefore I thought that it would
have to be a kernel module, not a userspace pgm.

> > How can I use the piano to control the computer ?
> >(while I am recording, or some third app is
> consuming
> >the MIDI stream on its own, and I have no control
> over
> >that app)
> 
> the sequencer can multiplex MIDI data to multiple
> clients. several
> clients can connect to the same sequencer port,
> and they will all see
> the data.

 I just tried a multiple (two) concurrent "cat
/dev/midi" and the first one succeeded, and the other
failed : "cat: /dev/midi: Device or resource busy".
How can "several clients connect to the same sequencer
port " so they all see the data ?

> --p

thx - john

PS: sorry for these broken up lines, yahoo gives me
pretty narrow box to work with. :-(


______________________________________________________________________ 
File your taxes online! http://taxes.yahoo.ca

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
