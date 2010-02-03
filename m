From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Access to bytes from the raw audio stream? (AC'97)
Date: Wed, 3 Feb 2010 16:59:24 +0000
Message-ID: <20100203165924.GA19503@rakim.wolfsonmicro.main>
References: <94cf76f1002030808t1d54dc08oab179673e814f016@mail.gmail.com>
	<20100203161737.GC12034@sirena.org.uk>
	<94cf76f1002030827p6b420c17wae026b19cd077e60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C92B22443B
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 17:59:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <94cf76f1002030827p6b420c17wae026b19cd077e60@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Graham <johngavingraham@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 03, 2010 at 04:27:05PM +0000, John Graham wrote:

> Basically, we've got a problem where we think our processor is
> bit-shifting the sample for some reason, and I was going to see if I
> could either (i) un-bit-shift it (it looks like we're not actually
> losing any data, the sound's just being multiplied by 2^4), or (ii)
> reproduce the problem we see by bit-shifting the samples on a
> known-good platform.

Presumably you can just bit shift the audio data in userspace?

> Would I be able to access samples quite early on in the generic AC'97
> code (I don't know where that is, either, but it would be interesting
> to see, at least :p)

As I said most AC97 controllers handle all the multiplexing and framing
in hardware so the generic AC97 layer doesn't deal with AC97 wire format
at all.  You will need to look at your AC97 controller driver.
