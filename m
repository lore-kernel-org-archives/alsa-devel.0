From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: About integer64
Date: Thu, 09 May 2002 15:25:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDA78CE.BE2D0F56@alsa-project.org>
References: <200205091256.OAA26239@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >What I'm misunderstanding? I tend to interpret the former and the latter
> >statements in a contradictory way.
> 
> my reading of the "docs" (the Mac OS X driver and utilities) is that
> RME haven't figured out a way to truncate the 64 bit fixed point
> representation to a 32 bit integer using the Xilinx FPGA. they have
> figured out how to render it as a 64 bit integer. so, they do the math
> using a fixed point representation, then transform to 64 bit integer
> when storing it in the register. the final part of the transform is
> done by the host CPU, in our case up in user space since we can't do
> float math conveniently in the kernel.
> 
> does that make it clearer?

Not very much:
a) if 32 bit integer could be enough expressive, what's the problem to
truncate it in your driver?
b) if a 32 bit integer is not enough and a float is preferrable:
considered that an ieee754 floating point is in the form (1+man)*2^exp
what's the problem in converting it in your driver using ffs and some
shift?

With both way I don't see the two point you make:
1) why bother with signed vs unsigned
2) why use 64 bit integer

Of course if a 64 bit integer is the best way to represent/report the
value all is fine, but in this case I doubt that you don't have
available the 64th bit for the sign.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
