From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 15:00:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD9216E.BB354D6A@alsa-project.org>
References: <200205081228.g48CSHD24864@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA06573
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 15:00:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >Just for curiosity, what they store that cannot be represented in 32
> >bits?!?
> 
> RMS meters. It seems that the 64 bit-ness comes from it being some
> kind of fixed point representation - the value that you read from the
> registers need scaling (in user space, presumably) by a floating point
> transformation to actually become true RMS values. so its not so much
> they they need 64 bits of precision, more that the hardware needs to
> do the math with this type of data format. keep in mind the
> computation is all being done on a Xilinx FPGA, not a DSP chip, so the
> arithmetic options are (at this time) a bit limited.

I expected something similar. Don't you think that to have a FLOAT type
is a better choice (more card independent, more accessible, more
representative, etc.).

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
