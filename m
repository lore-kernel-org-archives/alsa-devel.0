From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] beyond ARRAY_SIZE of s3c64xx_i2s
Date: Thu, 21 May 2009 18:59:01 +0100
Message-ID: <20090521175900.GA7895@sirena.org.uk>
References: <4A141D3E.7030609@gmail.com> <20090520151445.GC29689@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 559361037EE
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 19:59:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090520151445.GC29689@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2009 at 04:14:46PM +0100, Mark Brown wrote:
> On Wed, May 20, 2009 at 05:09:50PM +0200, Roel Kluin wrote:
> > Do not go beyond ARRAY_SIZE of s3c64xx_i2s
> > 
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

> Looks good, I'll apply this.

...or not, since it doesn't apply against current ALSA and the issue has
been fixed in a different way already.  I guess you're running some sort
of script looking for these issues, probably against current mainline?
It might be worth considering running against -next instead since that
will ensure that your patches apply more easily to people's current
development trees, or checking your results against -next to see if the
issue is still present.
