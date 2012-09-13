From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] [v2] ASoC: fsl: use
 snd_soc_register_card to register the card
Date: Thu, 13 Sep 2012 12:07:06 +0800
Message-ID: <20120913040705.GB6732@opensource.wolfsonmicro.com>
References: <1347380607-1564-1-git-send-email-timur@freescale.com>
 <20120912013211.GB9162@opensource.wolfsonmicro.com>
 <5050A673.3010401@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 931C1265241
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 06:07:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5050A673.3010401@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2012 at 10:12:51AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > I did explain what's wrong here - it's the use of driver data.

> Sorry, I didn't think to update the description with your explanation.

> Of course, now I need to figure out why my driver doesn't need driver data
> in order to work.

The driver data is used by the soc-audio driver to get the card.  Since
your driver now calls snd_soc_register_card() directly it doens't need
that.
