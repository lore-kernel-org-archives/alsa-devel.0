From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: rfc: rewrite commit subject line for subsystem
 maintainer preference tool
Date: Wed, 17 Nov 2010 17:07:47 +0000
Message-ID: <20101117170746.GB19488@rakim.wolfsonmicro.main>
References: <20101116104921.GL12986@rakim.wolfsonmicro.main>
	<1289919077.28741.50.camel@Joe-Laptop>
	<20101116183707.179964dd@schatten.dmk.lab>
	<20101116181226.GB26239@rakim.wolfsonmicro.main>
	<20101116203522.65240b18@schatten.dmk.lab>
	<20101116195530.GA7523@rakim.wolfsonmicro.main>
	<20101116122102.86e7e0b9.rdunlap@xenotime.net>
	<20101116230126.GB24623@opensource.wolfsonmicro.com>
	<20101117014427.41d85b13@stein>
	<alpine.LNX.2.00.1011170150060.7420@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8A16245CE
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 18:07:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011170150060.7420@pobox.suse.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Randy Dunlap <rdunlap@xenotime.net>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 17, 2010 at 01:53:35AM +0100, Jiri Kosina wrote:
> On Wed, 17 Nov 2010, Stefan Richter wrote:

> > Why should we codify our conventions in MAINTAINERS to accommodate the
> > specific problem of virtually a _single_ patch author?

It seems to be the way we're heading in general - look at all the recent
work on MAINTAINERS and get_maintainer.pl.  There seems to be a genral
push to make all this stuff automatable.

> Either the maintainer wants the patch. Then he is certainly able to apply 
> it no matter the subject line (I personally am getting a lot of patches 
> which don't follow the format I am using in my tree ... converting 
> Subject: lines is so trivial that I have never felt like bothering anyone 
> about it ... it's basically single condition in a shellscript). Or the 

It's slightly more than that if you're dealing with more than one area,
and I also find this sort of stuff is a good flag for scrubbing the
patch in greater detail - when patches stand out from a 1000ft visual
overview there's a fair chance that there's other issues so if people
regularly submit good patches that have only cosmetic issues I find it's
worth guiding them away from that.

> maintainer doesn't feel like the patch is worth it, and then the 
> subject-line format really doesn't matter.

In this case if I don't apply it it's likely to end up going in via your
tree and then I'll still have to deal with the merge conflicts which are
more annoying.
