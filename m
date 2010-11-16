From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: rfc: rewrite commit subject line for subsystem
 maintainer preference tool
Date: Tue, 16 Nov 2010 23:50:26 +0000
Message-ID: <20101116235025.GA7256@opensource.wolfsonmicro.com>
References: <1289919077.28741.50.camel@Joe-Laptop>
	<20101116183707.179964dd@schatten.dmk.lab>
	<20101116181226.GB26239@rakim.wolfsonmicro.main>
	<20101116203522.65240b18@schatten.dmk.lab>
	<20101116195530.GA7523@rakim.wolfsonmicro.main>
	<20101116122102.86e7e0b9.rdunlap@xenotime.net>
	<1289940156.28741.207.camel@Joe-Laptop>
	<20101116124609.382e42fb.rdunlap@xenotime.net>
	<20101116232258.GC24623@opensource.wolfsonmicro.com>
	<20101116152835.b0ab571c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 39C5A10381B
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 00:50:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101116152835.b0ab571c.rdunlap@xenotime.net>
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

On Tue, Nov 16, 2010 at 03:28:35PM -0800, Randy Dunlap wrote:
> On Tue, 16 Nov 2010 23:22:58 +0000 Mark Brown wrote:
> > On Tue, Nov 16, 2010 at 12:46:09PM -0800, Randy Dunlap wrote:

> > > Case usually doesn't matter to most of us.

> > Given that we're working in case sensitive languages here it's probably
> > safe to assume that a reasonable proportion of people will care; being
> > reasonably consistent with existing practice for the subsystem seems
> > sensible.

> Greg takes patches that say STAGING or Staging or staging.

> DaveM takes patches that say net: or netdev: or network: or NET:

> The sound maintainers take patches that say sound: or alsa: or ALSA:

> etc.

...and best practice would be to pay attention to what the standard
thing is for the subsystem and follow that.  We shouldn't be suggesting
that people just ignore the case, though obviously if it's not clear
then it's not worth worrying too much about it.
