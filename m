From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 15:26:34 +0100
Message-ID: <20100216142633.GA25489@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id AB24E243C2
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 15:27:01 +0100 (CET)
Content-Disposition: inline
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16.02.10 09:08, Clemens Ladisch (clemens@ladisch.de) wrote:

> 
> Lennart Poettering wrote:
> > Getting back to the invalid dB data from the USB cards: the question
> > is whether the USB descriptor data is badly parsed, and the dB
> > mismatch hence systematic for USB cards,
> 
> USB descriptors use units of 1/256th dB, while ALSA uses 1/100th dB.
> When the level is computed from the minimum plus a multiple of the step
> size, rounding errors add up considerately.
> 
> ALSA 1.0.21 (kernel 2.6.32) added a different TLV type that reports the
> range with the min/max values to minimize those rounding errors.

I am really sure that the discrepancy I measure with the Aureon is way
beyond rounding errors.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
