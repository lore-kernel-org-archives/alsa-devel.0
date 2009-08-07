From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: MPC5200/WM9712 mute problem
Date: Fri, 7 Aug 2009 10:56:02 +0100
Message-ID: <20090807095601.GA8175@rakim.wolfsonmicro.main>
References: <20090731230311.17686.46431.stgit@riker>
	<9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
	<1249139096.4582.13.camel@riker>
	<20090802114950.GA1778@sirena.org.uk>
	<1249489853.4582.58.camel@riker>
	<20090805170305.GC16844@sirena.org.uk>
	<1249579721.5844.88.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14B9B103875
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 11:56:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249579721.5844.88.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 10:28:41AM -0700, John Bonesio wrote:

> I'm open to more suggestions or thoughts on the approach I've taken so
> far.

The approach you've been taking sounds reasonable; at this point I'd be
looking at trying to confirm that the controller is doing what's been
asked of it.  Checking that the CODEC power rails are all within spec
and looking at other bits in the same register may also be useful.

Is the system otherwise idle when the problem occurs?
