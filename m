From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: I want to dmix for my MIPS board, how can I do?
Date: Mon, 7 Mar 2005 21:13:14 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0503072111050.1751@pnote.perex-int.cz>
References: <BAY16-DAV3AADC75FFB21EB73AE296E95F0@phx.gbl> <1110224111.935.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110224111.935.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: =?UTF-8?Q?=E6=9D=8E=E5=BB=BA?= =?UTF-8?Q?=E5=9D=A4?= <li_jiankun@hotmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Mar 2005, Lee Revell wrote:

> On Mon, 2005-03-07 at 22:24 +0800, ??? wrote:
> > alsa-devel,
> > 
> >   I'm an device driver developer for MIPS board. Now, I'm in urgent need of dmix source code for my Achemy board.
> >   I want to dmix on my MIPS Au1x00 board, Segmentation Fault occurs. I look up the code of pcm_dmix.c for possible reason, 
> >   it says,
> >     #warning Please, recode mix_areas1() routine to your architecture...
> > 	warning Please, recode mix_areas2() routine to your architecture...
> >   Does it mean the dmix can only be used on X86 architecture now?
> >   if I want to use it on my MIPS board, how can I do? 
> >   
> >   Looking forward to anyone's reply! Tanks in advance!
> 
> Yup, that's exactly what it means.  Dmix is only implemented for x86
> now.  If you want to use it on another arch you have to code it
> yourself.
> 
> But, isn't there a cleaner way to handle this than segfaulting?  Why do
> we even compile the plugin for non-x86 archs?

Well, there is some C code which can be compiled for all archs. Although 
it won't work correctly, it will give a clue, what needs to be written in 
assembler.

It might be that this code is buggy. Do we know the segfault point in 
alsa-lib (backtrace)?
	
					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
