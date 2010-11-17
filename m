From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: rfc: rewrite commit subject line for subsystem maintainer
 preference tool
Date: Wed, 17 Nov 2010 01:44:27 +0100
Message-ID: <20101117014427.41d85b13@stein>
References: <1289848458.16461.150.camel@Joe-Laptop>
	<20101115193407.GK12986@rakim.wolfsonmicro.main>
	<1289850773.16461.166.camel@Joe-Laptop>
	<20101116104921.GL12986@rakim.wolfsonmicro.main>
	<1289919077.28741.50.camel@Joe-Laptop>
	<20101116183707.179964dd@schatten.dmk.lab>
	<20101116181226.GB26239@rakim.wolfsonmicro.main>
	<20101116203522.65240b18@schatten.dmk.lab>
	<20101116195530.GA7523@rakim.wolfsonmicro.main>
	<20101116122102.86e7e0b9.rdunlap@xenotime.net>
	<20101116230126.GB24623@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101116230126.GB24623@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Florian Mickler <florian@mickler.org>, Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Nov 16 Mark Brown wrote:
> On Tue, Nov 16, 2010 at 12:21:02PM -0800, Randy Dunlap wrote:
> 
> > I don't know what you asked Joe to change, but asking someone to use
> > the documented canonical patch format:
> 
> > <quote>
> > The canonical patch subject line is:
> 
> >     Subject: [PATCH 001/123] subsystem: summary phrase
> > </quote>
> 
> > should be fine.  And there is no need for printf-ish templates
> > for this in MAINTAINERS either.
> 
> That's exactly what I asked him to do.  He said he's not willing to use
> anything for "subsystem" which can't be automatically generated.

Why should we codify our conventions in MAINTAINERS to accommodate the
specific problem of virtually a _single_ patch author?

Conventions are living and are being adjusted all the time, as code
organization changes, people join and go, projects start and cease.

Said author please looks the conventions up in the git history.  If he
finds that this decelerates his patch generation rate, he can surely
code a script that looks into git for him and suggests plausible
prefixes for his patch titles to him.  Or he can collect a kind of
database (a config file) locally for his own use in which he records
conventional prefixes on the go.
-- 
Stefan Richter
-=====-==-=- =-== =---=
http://arcgraph.de/sr/
