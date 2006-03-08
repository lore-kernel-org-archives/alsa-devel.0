From: Nicolas Pitre <nico@cam.org>
Subject: Re: iPAQ H5xxx audio driver
Date: Wed, 08 Mar 2006 17:32:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603081728000.20617@localhost.localdomain>
References: <1141857195.24748.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1141857195.24748.37.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@gmail.com>
Cc: Alsa-devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 8 Mar 2006, Manuel Jander wrote:

> Playing around with the ..._MMAP and ..._MMAP_VALID info changed
> somewhat the segfaulting behaviour, so I guess that kernel mmap
> functionality could be part of the problem. For some few times aplay did
> even work without segfaulting, when the ...MMAP_VALID flag was removed
> from the info field.
> 
> The iPAQ does not seem to have a PCI bus and the current ALSA driver
> tree does not compile cleanly for this target (requires some few
> preprocessor macro changes). I'm using (at least I think I do so) ISA
> bus coherent memory allocation methods for the DMA buffers.
> 
> I'm using familiar's linux 2.4.19-rmk6-hh37 kernel on a iPAQ H5550 ...

I'd strongly suggest you study the drivers present in linux/sound/arm/ 
in a recent 2.6.x kernels.  On ARM you need to use ARM specific 
functions to allocate coherent memory to be used with DMA and you might 
have to backport those to 2.4 for proper ALSA support.


Nicolas


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
