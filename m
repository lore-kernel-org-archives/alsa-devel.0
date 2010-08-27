From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: S3C64XX: Fix fallthrough bug in	i2sv3
	gpio configuration, improve logging
Date: Fri, 27 Aug 2010 11:26:06 +0100
Message-ID: <20100827102606.GA14881@opensource.wolfsonmicro.com>
References: <1282835243-20493-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20100826152140.GB4363@opensource.wolfsonmicro.com>
	<1282904320.3025.2.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 571382453F
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 12:26:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282904320.3025.2.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 27, 2010 at 11:18:40AM +0100, Liam Girdwood wrote:
> On Thu, 2010-08-26 at 16:21 +0100, Mark Brown wrote:
> > On Thu, Aug 26, 2010 at 04:07:23PM +0100, Dimitris Papastamos wrote:
> > 
> > > This is a fix for a change in ASoC multi-component as well.
> > 
> > Clarifying from offline discussion: the issue isn't present in mainline,
> > it came in with m-c.
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
