From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 20:03:13 +0100
Message-ID: <20090809190312.GB4390@sirena.org.uk>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
	<20090809104830.GC4773@sirena.org.uk>
	<9e4733910908090632m1178daceya0269966fde54529@mail.gmail.com>
	<20090809143747.GA9121@sirena.org.uk>
	<9e4733910908090810r56b6fc19p2c671b728f13327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E6F24359
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 21:03:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910908090810r56b6fc19p2c671b728f13327@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 09, 2009 at 11:10:24AM -0400, Jon Smirl wrote:

> We don't need to declare an endianess because it is fixed in the standard.
> Now the ifdefs in the h file make this work for both BE and LE.

The ifdefs in the header file define only the native endianness.
There's no reason why an AC97 controller can't do byte swapping for
itself but if we use the non-specific constants only native endianness
will be advertised by the CODEC.

> This also hides another implicit conversion. The AC97 codecs only take
> 24b. Again it is the host controller that is converting 8/16/32 to
> 24b.

This is exactly why we're defining this standard format for AC97
devices.  The formats are just placeholders to make the standard
matching stuff work without having to teach it about AC97, they have no
influence on the behaviour of the CODEC.
