From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: Developing SIS 962L driver.
Date: Sat, 5 Jul 2003 13:53:14 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030705185314.GT24005@dbz.icequake.net>
References: <200307051204.AA1763115658@enroute-computer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200307051204.AA1763115658@enroute-computer.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Robert,

On Sat, Jul 05, 2003 at 12:04:47PM -0400, Robert Liguori wrote:
> Hello all,
> 
> I would like to write a driver for SIS 962L.
> 
> I am new at this.  Could anyone please answer the following questions for me?
> 
> 1)  What tools/applications do I need to write a driver.

Your C compiler, a copy of ALSA, a copy of the specification, your
brain, that's about all. :)

> 2)  Can you give me an example of a complete set of .c and .h files that constitute a new driver, and what application does it get appended to.  Will it become part of the kernel, or will it be maintained as an external mod?

It builds a snd-xxxxx.o kernel module where xxxxx is the name of your
chip.  That module may be loaded after the rest of the ALSA framework is
loaded, such as snd-pcm, snd-timer, as well as any ALSA modules it may
depend on.  I.E. if your driver uses the AC97 code, it will depend on
snd-ac97-codec being loaded.

> 3)  Where can I get the specs to build this driver.  Exactly what data/specifications do I need.

If they are not under http://www.alsa-project.org/alsa/ftp/manuals/ then
you will have to beg SiS for the documentation.  Unfortunately they have
not been forthcoming e.g. to the DRI people.

> 4)  I am a novice C/C++ programmer.  Will my skillset be sufficient to accomplish this task.

It depends how well you can read the specification and mimic the
existing ALSA drivers.  Building a driver within the ALSA framework is
not hard because ALSA does most of the work for you, you just have to
provide the glue between ALSA and the hardware.

If you are not well versed in C, that will be a roadblock.  If you are
not familiar with how the machine works, how to do port I/O, how data is
stored in memory, then that will make it even more difficult.  Not
insurmountable, but you will have to learn these things first. :)

> 5)  What books or online resources ( in addition to this list ) are available to help me achieve my goal.

Check out "Writing An ALSA Driver" by Takashi.  You can find it from
Google.

> 6)  Is there any other information that I need to know, that I may not even know to ask about?

The answer to the question is 42.  You must find the question for
yourself. ;)

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
