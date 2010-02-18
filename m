From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Thu, 18 Feb 2010 03:37:42 +0100
Message-ID: <20100218023742.GC23637@tango.0pointer.de>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A82951038B2
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 03:38:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
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

On Thu, 18.02.10 09:48, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> From the viewpoint of user, they only care how easy to find the point which
> is no software gain or software auttentation  since software gain lead to
> clipping

We decided to expose software amplification in the UI, since it is
actually a much requested feature, and I have used myself a couple of
times.

The primary use case is when you play a DVD (which very often has
audio normalized to a very low volume) on weak speakers, such as
laptop speakers.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
