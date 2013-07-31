From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Fix resource leak
Date: Wed, 31 Jul 2013 13:00:25 +0100
Message-ID: <20130731120025.GA26590@opensource.wolfsonmicro.com>
References: <1375262118-9183-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <20130731112331.GL9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73F3B261606
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 14:00:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130731112331.GL9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 12:23:31PM +0100, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 10:15:18AM +0100, Dimitris Papastamos wrote:
> 
> > +		xfer = kzalloc(sizeof(*xfer), GFP_KERNEL | GFP_DMA);
> > +		if (!xfer) {
> > +			dev_err(codec->dev, "Failed to allocate xfer\n");
> > +			ret = -ENOMEM;
> > +			goto abort1;
> > +		}
> > +
> 
> Why is this being allocated with GFP_DMA?  It's an internal data
> structure, it's not going to be DMAed from.

Yeah I will send a separate patch to fix that and then rebase
this patch on top.

> Please also provide a changelog, a link to some address on the web isn't
> a useful description.

Will do.
