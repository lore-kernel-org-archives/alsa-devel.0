From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: rfc: rewrite commit subject line for subsystem
 maintainer preference tool
Date: Tue, 16 Nov 2010 15:04:51 +0000
Message-ID: <20101116150451.GA26239@rakim.wolfsonmicro.main>
References: <20101115173031.GI12986@rakim.wolfsonmicro.main>
	<1289842444.16461.140.camel@Joe-Laptop>
	<20101115182708.GJ12986@rakim.wolfsonmicro.main>
	<1289845830.16461.149.camel@Joe-Laptop>
	<20101115190738.GF3338@sirena.org.uk>
	<1289848458.16461.150.camel@Joe-Laptop>
	<20101115193407.GK12986@rakim.wolfsonmicro.main>
	<1289850773.16461.166.camel@Joe-Laptop>
	<20101116104921.GL12986@rakim.wolfsonmicro.main>
	<1289919077.28741.50.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CED8D243CD
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 16:04:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289919077.28741.50.camel@Joe-Laptop>
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
Cc: Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 16, 2010 at 06:51:17AM -0800, Joe Perches wrote:

> Maybe add a new MAINTAINERS section line something like:
> 	"C:	CommitSubjectGrammarStyle"
> where CommitSubjectGrammarStyle is something more
> information rich than "style 1", "style 2".

Something printfish would seem reasonable?

> Also, what would you expect the output to be when a single
> patch modified files from 2 subsystems that use different
> styles?

The traditional thing is "ThingX/ThingY: blah" but as with anything else
you need to be sensible.
