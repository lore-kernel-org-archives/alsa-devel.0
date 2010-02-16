From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 15:32:01 +0100
Message-ID: <20100216143200.GB25489@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 63B97103827
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 15:32:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16.02.10 09:24, Jaroslav Kysela (perex@perex.cz) wrote:

> > ALSA 1.0.21 (kernel 2.6.32) added a different TLV type that reports the
> > range with the min/max values to minimize those rounding errors.
> 
> Unfortunately, it's not the case of a rounding problem. The USB 
> specification is too much vague and vendors don't use the dB range 
> correctly. For example, I tested SB MP3+ USB device and reported ranges 
> were:
> 
> Master: -47.87dB..0.06dB	# correct
> Line: 0dB..47.81dB		# seems correct -47.81dB..0dB
> Line Capture: -0.18dB..23.81dB	# seems correct
> -17.81dB..6.18dB

Hmm, how did you choose where to put 0dB?

> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=c3a3e040f01457d2ea4f199f75ca205401001a3b
> 
> The SB MP3+ uses AC97 codec AD1995 with some own ASIC from Creative. So I 
> think that even the 47.87 values are not correct and the real ranges are
> from -48dB..0dB and -18dB..6dB.

So if I understand this correctly, then the way to handle issues like
this is to measure the dB data for each USB card in question and then
update the drivers with quirks accordingly? 

So if I want my Aureon to work properly I better start measuring now?

Would it be feasible to allow overriding of the dB data from
userspace, i.e. from the alsa mixer init db perhaps?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
