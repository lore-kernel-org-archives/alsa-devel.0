From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [asoc:for-3.7 95/95]
 sound/soc/codecs/wm0010.c:850:7-27: ERROR: Threaded IRQ with no primary
 handler requested without IRQF_ONESHOT
Date: Thu, 6 Sep 2012 06:39:12 +0800
Message-ID: <20120905223912.GA9599@localhost>
References: <20120830151652.GB11964@localhost>
 <20120905054024.GA16276@sirena.org.uk>
 <20120905055609.GA7463@localhost>
 <20120905120546.GB16276@sirena.org.uk>
 <alpine.DEB.2.02.1209051533070.2122@hadrien>
 <20120905134827.GA8694@localhost>
 <alpine.DEB.2.02.1209051552190.2122@hadrien>
 <20120905140651.GA8947@localhost>
 <alpine.DEB.2.02.1209052200280.1912@hadrien>
 <20120905222048.GB10580@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C6C260318
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 00:39:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120905222048.GB10580@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Julia Lawall <julia.lawall@lip6.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 06, 2012 at 06:20:50AM +0800, Mark Brown wrote:
> On Wed, Sep 05, 2012 at 10:01:12PM +0200, Julia Lawall wrote:
> 
> > I'm not sure what could be done better...
> 
> The patch itself was fine but it was buried as an attachment to a mail
> that didn't have anything like a [PATCH] tag or anything so it was very
> hidden when it turned up in e-mail.

Yes, this is a problem. I'll avoid such hidden coccinelle patches in future.

Thanks for the reminding!

Fengguang
