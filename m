From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: Re: About integer64
Date: Thu, 09 May 2002 14:32:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDA6C72.42150590@alsa-project.org>
References: <E175llC-0006zb-00@usw-sf-list1.sourceforge.net>
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
> >
> >I don't think that's a bad thing to have support for 64 bit integers
> >(perhaps for future use, who knows), but I think that to use this to
> >store a fixed point float is a big mistake.
> >
> >If you think for it you realize that it's *not* an integer and
> >applications are betrayed in their expectation.
> 
> in this case, it *is* an integer. your original question was about why
> its 64 bits - i think that comes from the fixed point internal
> arithmetic. but the end result is a straightforward 64 bit little
> endian integer that needs scaling to get the actual RMS value.

You wrote:

> It seems that the 64 bit-ness comes from it being some
> kind of fixed point representation - the value that you read from the
> registers need scaling (in user space, presumably) by a floating point
> transformation to actually become true RMS values. so its not so much
> they they need 64 bits of precision, more that the hardware needs to
> do the math with this type of data format. keep in mind the
> computation is all being done on a Xilinx FPGA, not a DSP chip, so the
> arithmetic options are (at this time) a bit limited.

What I'm misunderstanding? I tend to interpret the former and the latter
statements in a contradictory way.

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
