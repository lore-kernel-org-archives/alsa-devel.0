From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is correct way to put conditional stuff in
 ASoC codec driver?
Date: Fri, 1 Jul 2011 09:17:50 -0700
Message-ID: <20110701161749.GD23784@opensource.wolfsonmicro.com>
References: <1309437990.15931.67.camel@matrix>
	<20110630163706.GA18120@sirena.org.uk>
	<1309509205.15931.89.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B7A8247B5
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 18:17:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309509205.15931.89.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 01, 2011 at 02:03:25PM +0530, Ashish Chavan wrote:
> On Thu, 2011-06-30 at 22:07 +0530, Mark Brown wrote:

> > You'd need to implement custom controls for the relevant enables which
> > check to see what is currently enabled and prevents enables if there
> > are conflicts.  You should do this dynamically and I'd expect that only
> > the enables actually need to check anything, adjusting parameters for
> > things that aren't active is usually no problem.

> I see. That means it's ok to allow setting up values of five band
> equalizers even when overall equalizer functionality is disabled.
> Can you point me to any existing code that has such custom control(s)
> which need to check for similar conditions? I am sure that many existing
> codecs would have this kind of inter dependent functions.

This requirement is actually fairly unusual, but there's plenty of
drivers with open coded controls for various reasons.  Have you tried
looking at the existing drivers in mainline?
