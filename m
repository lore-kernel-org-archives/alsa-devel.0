From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 09:24:11 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 49232245DE
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 09:24:12 +0100 (CET)
In-Reply-To: <4B7A5268.5050704@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Feb 2010, Clemens Ladisch wrote:

> Lennart Poettering wrote:
>> Getting back to the invalid dB data from the USB cards: the question
>> is whether the USB descriptor data is badly parsed, and the dB
>> mismatch hence systematic for USB cards,
>
> USB descriptors use units of 1/256th dB, while ALSA uses 1/100th dB.
> When the level is computed from the minimum plus a multiple of the step
> size, rounding errors add up considerately.
>
> ALSA 1.0.21 (kernel 2.6.32) added a different TLV type that reports the
> range with the min/max values to minimize those rounding errors.

Unfortunately, it's not the case of a rounding problem. The USB 
specification is too much vague and vendors don't use the dB range 
correctly. For example, I tested SB MP3+ USB device and reported ranges 
were:

Master: -47.87dB..0.06dB	# correct
Line: 0dB..47.81dB		# seems correct -47.81dB..0dB
Line Capture: -0.18dB..23.81dB	# seems correct -17.81dB..6.18dB

I just did tests using another soundcard to generate sounds and 
played back the captured result to determine the gain in the capture 
direction.

I put my results to:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=c3a3e040f01457d2ea4f199f75ca205401001a3b

The SB MP3+ uses AC97 codec AD1995 with some own ASIC from Creative. So I 
think that even the 47.87 values are not correct and the real ranges are
from -48dB..0dB and -18dB..6dB.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
