From: Paul Davis <pbd@Op.Net>
Subject: Re: Rawmidi bug or missed feature?
Date: Sat, 02 Mar 2002 14:31:50 -0500
Message-ID: <200203021931.OAA16335@renoir.op.net>
In-reply-to: Your message of "Sat, 02 Mar 2002 20:15:44 +0100."
             <3C8124E0.4FDDECD1@ufh.se>
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

>How can we get the same performance i userspace? For me it is the
>processor/OS schedule that gives the limit for that, and in kernel we
>get
>the hardware as the limit.

there are two things done by the sequencer:

     a) routing/multiplexing
	
	this is mostly a matter of code design and memory management,
	and can be handled just as well in user space as in the
	kernel, perhaps even better (other libs can be used, for
	instance). there is almost nothing i can think of relating to
	this work that requires or even benefits from a kernel side
	location. 

     b) scheduling
     
        the kernel has no special access to system hardware for timing
	that is not available to a root-enabled or CAP_RESOURCE-enabled	
	task. the default system timer that the vast majority of
	sequencer users will use is of much worse resolution than some
	of the alternatives such as the RTC and a PCM audio
	clock.	

	however, both of these sources (as well as the default system
	timer) are available to user space processes. there is a
	small overhead involved, on the order of 2-10 microseconds, if
	that. 

	Since the sequencer would have to run with these permissions
	to be useful, as a user space process it has the same
	scheduling capabilities as it does in the kernel (for our
	purposes; obviously, it can't schedule processes in the same
	way as the OS task scheduler, but then for that matter,
	neither can the existing kernel sequencer).

	the processor has no part to play in scheduling except for
	executing code. fast processors don't schedule faster other
	than in the sense that they execute the scheduling code
	(whether its in user space or not) more or less quickly.
	
By putting the sequencer in user space we:

  a) remove a large and necessarily complex piece of code from the
       kernel, nearly always a good thing
  b) allow it to be developed more flexibly (code errors don't
       cause system panics or hangs)
  c) can make it more modular
  d) can port it to non-Linux systems more easily
  e) can extend it to work within or alongside other designs more easily

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
