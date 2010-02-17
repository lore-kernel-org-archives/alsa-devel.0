From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 09:08:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002170858110.28127@eeebox2.perex-int.cz>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<ad2655cb1002161348p7be432a1qb5fcf28804ef5c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D27D24555
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 09:08:43 +0100 (CET)
In-Reply-To: <ad2655cb1002161348p7be432a1qb5fcf28804ef5c00@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Feb 2010, James Courtier-Dutton wrote:

> I guess a good start would be what digital values should create what
> voltages on the line output?
> One can then at least get the 0dB point set right.

It seems that I have to buy a precise voltmeter or good digital 
oscilloscope to get these results :-) Anyway, the voltage levels 
expressions are described nicely here:

http://en.wikipedia.org/wiki/Decibel

>From above pro-equipment works with 0.775V as reference volume (0dBu) 
and consumer electronics with 1V as reference volume (0dBV).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
