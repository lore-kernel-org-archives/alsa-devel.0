From: Paul Davis <pbd@op.net>
Subject: Re: Re: About integer64
Date: Thu, 09 May 2002 08:57:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E175nSs-0005qq-00@usw-sf-list1.sourceforge.net>
References: <3CDA6C72.42150590@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 09 May 2002 14:32:50 +0200."
             <3CDA6C72.42150590@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>What I'm misunderstanding? I tend to interpret the former and the latter
>statements in a contradictory way.

my reading of the "docs" (the Mac OS X driver and utilities) is that
RME haven't figured out a way to truncate the 64 bit fixed point
representation to a 32 bit integer using the Xilinx FPGA. they have
figured out how to render it as a 64 bit integer. so, they do the math
using a fixed point representation, then transform to 64 bit integer
when storing it in the register. the final part of the transform is
done by the host CPU, in our case up in user space since we can't do
float math conveniently in the kernel.

does that make it clearer?

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
