From: Paul Davis <pbd@op.net>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 08:29:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205081228.g48CSHD24864@post2.fast.net>
References: <3CD8DC1F.709754AF@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 08 May 2002 10:04:47 +0200."
             <3CD8DC1F.709754AF@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Just for curiosity, what they store that cannot be represented in 32
>bits?!?

RMS meters. It seems that the 64 bit-ness comes from it being some
kind of fixed point representation - the value that you read from the
registers need scaling (in user space, presumably) by a floating point
transformation to actually become true RMS values. so its not so much
they they need 64 bits of precision, more that the hardware needs to
do the math with this type of data format. keep in mind the
computation is all being done on a Xilinx FPGA, not a DSP chip, so the
arithmetic options are (at this time) a bit limited.

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
