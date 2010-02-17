From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from
 USB	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 14:01:55 +0100
Message-ID: <20100217130155.GC24165@tango.0pointer.de>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<20100217111721.GA2032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8F0103874
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:02:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100217111721.GA2032@sirena.org.uk>
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

On Wed, 17.02.10 11:17, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:

> 
> On Wed, Feb 17, 2010 at 12:56:58AM +0100, Lennart Poettering wrote:
> 
> > Nah. I actually don't need this value for PulseAudio. In PulseAudio I
> > chose to shift all scales so that maximum amplification becomes 0 dB,
> > so that the UIs are similar to how most hifi racks do it, and which I
> 
> Interesting.  The hifi equipment I've dealt with typically doesn't
> present any units at all in the UI outside of level monitors.

My old Yamaha hifi rack had a volume dial where the max was labeled 0
dB and the min setting was -inf dB. My new Yamaha shows the dB level
on an LCD screen whever you touch the volume dial, and it too goes
from -inf dB to 0 dB. I kinda assumed that stereos from other
manufacturers would do the exact same thing, but tbh never checked.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
