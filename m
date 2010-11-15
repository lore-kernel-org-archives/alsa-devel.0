From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 44/44] sound/soc/codecs: Remove unnecessary
	semicolons
Date: Mon, 15 Nov 2010 19:34:07 +0000
Message-ID: <20101115193407.GK12986@rakim.wolfsonmicro.main>
References: <cover.1289789604.git.joe@perches.com>
	<97fd199b7dac50613f6843156687223928cce44a.1289789605.git.joe@perches.com>
	<20101115134939.GC12986@rakim.wolfsonmicro.main>
	<1289840957.16461.138.camel@Joe-Laptop>
	<20101115173031.GI12986@rakim.wolfsonmicro.main>
	<1289842444.16461.140.camel@Joe-Laptop>
	<20101115182708.GJ12986@rakim.wolfsonmicro.main>
	<1289845830.16461.149.camel@Joe-Laptop>
	<20101115190738.GF3338@sirena.org.uk>
	<1289848458.16461.150.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C6502453F
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 20:34:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289848458.16461.150.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 11:14:18AM -0800, Joe Perches wrote:
> On Mon, 2010-11-15 at 19:07 +0000, Mark Brown wrote:

> > I'd suggest using pattern matching to look up the
> > rules for generating the prefixes (it's pretty much entirely prefixes)
> > in the same way you're handling figuring out who to mail - that'd
> > probably cover it in an automatable fashion.

> Publish a tool that works and I'll use it.

It appears your scripts are already hooked into get_maintainers.pl which
would seem the obvious place to do this?  Sadly I don't do perl, though
it looks like you're doing pretty much all the work on that anyway.

The main thing here is to avoid your patches sticking out - as well as
the hassle applying them stuff like this is also a red flag on review.
