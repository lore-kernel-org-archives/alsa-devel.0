From: Paul Davis <pbd@Op.Net>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 02 Mar 2002 13:58:10 -0500
Message-ID: <200203021858.NAA13670@renoir.op.net>
In-reply-to: Your message of "Sat, 02 Mar 2002 19:37:48 +0100."
             <3C811BFC.4F267BEC@ufh.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Enderborg <pme@ufh.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>How do you solve the problem with sharing hardware then?

I don't. I intend to wait for (and contribute too, if I can) what I
consider the correct solution:

  a) sequencer genuinely split into:

          1) a router/multiplexer
	  2) a scheduler

  b) sequencer moves into user space

As I've said before, I don't consider the current kernel-side
implementation of the sequencer, nor its merging of two completely
different functions, to be in anyone's interest. I think that Frank
was (like myself and everyone else) somewhat "blinded" by the fact
that OSS put the sequencer in the kernel, and we did not know that it
was possible to get similar performance in user space.

For the time being, I have hardware solutions that work for me when I
need to do complex MIDI routing (i.e. dedicated h/w MIDI patchbays),
and I never run multiple apps using the same port.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
