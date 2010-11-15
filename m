From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 44/44] sound/soc/codecs: Remove unnecessary
	semicolons
Date: Mon, 15 Nov 2010 19:07:38 +0000
Message-ID: <20101115190738.GF3338@sirena.org.uk>
References: <cover.1289789604.git.joe@perches.com>
	<97fd199b7dac50613f6843156687223928cce44a.1289789605.git.joe@perches.com>
	<20101115134939.GC12986@rakim.wolfsonmicro.main>
	<1289840957.16461.138.camel@Joe-Laptop>
	<20101115173031.GI12986@rakim.wolfsonmicro.main>
	<1289842444.16461.140.camel@Joe-Laptop>
	<20101115182708.GJ12986@rakim.wolfsonmicro.main>
	<1289845830.16461.149.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D864524538
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 20:07:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289845830.16461.149.camel@Joe-Laptop>
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

On Mon, Nov 15, 2010 at 10:30:29AM -0800, Joe Perches wrote:
> On Mon, 2010-11-15 at 18:27 +0000, Mark Brown wrote:
> > On Mon, Nov 15, 2010 at 09:34:04AM -0800, Joe Perches wrote:

> > > I think it's more important to use consistent changelogs
> > > for a patch series.

> > ...since...?

> 1995...

That's not really a reason.  It seems that...

> Since there isn't a consistent standard for subsystems
> changelogs and automating scripts for the desires of
> individual subsystem maintainers is not feasible.

...you mean that you wish to do this since it makes your life as a
script author easier.  I'd suggest using pattern matching to look up the
rules for generating the prefixes (it's pretty much entirely prefixes)
in the same way you're handling figuring out who to mail - that'd
probably cover it in an automatable fashion.
