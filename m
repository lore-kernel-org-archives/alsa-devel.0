From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from
 USB	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 16:40:16 +0100
Message-ID: <20100216154015.GA612@tango.0pointer.de>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F94F24133
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 16:40:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100216144047.GB10586@sirena.org.uk>
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

On Tue, 16.02.10 14:40, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Tue, Feb 16, 2010 at 03:32:01PM +0100, Lennart Poettering wrote:
> > On Tue, 16.02.10 09:24, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > > Line: 0dB..47.81dB		# seems correct -47.81dB..0dB
> > > Line Capture: -0.18dB..23.81dB	# seems correct
> > > -17.81dB..6.18dB
> 
> > Hmm, how did you choose where to put 0dB?
> 
> The Line one looks like someone got attenuation and gain confused, which
> is a fairly common mistake for people to make when copying information
> from one place to another.  Possibly a similar thing going on with the
> Line Capture control, plus a fixed 6dB gain (which may well be a
> separate amp...).

I remember that a while back we had a discussion on alsa-devel
regarding the fact that ALSA does not define relative to what the dB
values reported by the mixer elements actually are measured. Some
mixer controls export dB values relative to max amplification (e.g. my
integrated USB speakers here), others relative to the output of some
other mixer element, and others relative to different standard or
not-so-standard output voltages.  And there is no API to figure out
what the base is.

Now, what Jaroslav listed above suggests that he chose carefully where
he put 0dB. I was just wondering about that. Jaroslav, how did you
choose where to put 0dB?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
