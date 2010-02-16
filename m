From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from
 USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 00:56:58 +0100
Message-ID: <20100216235658.GA6766@tango.0pointer.de>
References: <4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A39510383C
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 00:57:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100216233825.GB23623@sirena.org.uk>
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

On Tue, 16.02.10 23:38, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Tue, Feb 16, 2010 at 11:42:12PM +0100, Lennart Poettering wrote:
> > On Tue, 16.02.10 22:39, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
> 
> > > Typically the DACs and ADCs will have a full scale signal at line
> > > reference level - it should generally be a good approximation with
> > > nothing else to go on.
> 
> > "line reference level"? What is that?
> 
> As I understand it (and bear in mind that I'm a software rather than
> electrical engineer) it's not 100% fixed, though since the actual result
> depends very much on what it's connected to an absolute answer isn't as
> important as it might be.  1V RMS is very standard in consumer stuff at
> least.
> 
> If you could frame exactly the information that you're looking for then
> I should be able to ask a few people who are electrical engineers and
> get a more coherent answer for you.   I guess you're looking at trying
> to have PulseAudio set sensible levels by default?

Nah. I actually don't need this value for PulseAudio. In PulseAudio I
chose to shift all scales so that maximum amplification becomes 0 dB,
so that the UIs are similar to how most hifi racks do it, and which I
think is a nice, easy and understandable logic. That way my volume
scales range from -inf dB to 0 dB in all cases, regardless of the
hardware/drivers in use. Of course, that means that ALSA's own 0dB is
not directly visible on the scale. Because it might be sometimes
useful to know where it is, we export that position as "base volume"
and the UIs show it with a little marker at the side.

The reason I was asking how Jaroslav chose the 0dB position for his
measurements was purely because I wanted to do my own measurements for
that Aureon card. The dbmeasure tool I wrote for stuff like that puts
0dB at max amplification, however Jaroslav didn't, so I was wondering
how he chose 0dB then.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
