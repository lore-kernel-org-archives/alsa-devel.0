From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: rfc: rewrite commit subject line for subsystem
 maintainer preference tool
Date: Tue, 16 Nov 2010 23:01:26 +0000
Message-ID: <20101116230126.GB24623@opensource.wolfsonmicro.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F24201037E3
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 00:01:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101116122102.86e7e0b9.rdunlap@xenotime.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: alsa-devel@alsa-project.org, Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 16, 2010 at 12:21:02PM -0800, Randy Dunlap wrote:

> I don't know what you asked Joe to change, but asking someone to use
> the documented canonical patch format:

> <quote>
> The canonical patch subject line is:

>     Subject: [PATCH 001/123] subsystem: summary phrase
> </quote>

> should be fine.  And there is no need for printf-ish templates
> for this in MAINTAINERS either.

That's exactly what I asked him to do.  He said he's not willing to use
anything for "subsystem" which can't be automatically generated.

The formats I mentioned because some subsystems have their own things
within this format like "subsystem: driver:" or whatever.  While it's
probably not an issue for the sort of patch Joe generates if we do have
a tool for this I'd expect it'll go the same way that checkpatch does
and get used by people doing more specific work.  It'd be good to try to
head off the friction that may cause by at least having an idea how we
might cope with that.
