From: Richard Lyons <richard@the-place.net>
Subject: Re: unable to get alsa configured on Acer Aspire 1640Z
Date: Mon, 18 Feb 2008 16:38:59 +0100
Message-ID: <20080218153854.GA3607@mulinocarletti.com>
References: <20080217171832.GI7750@mulinocarletti.com>
	<1203299465.3308.4.camel@localhost.localdomain>
	<20080218152156.GA3471@mulinocarletti.com>
	<s5hskzqthgh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tallyho.bytemark.co.uk (tallyho.bytemark.co.uk [80.68.81.166])
	by alsa0.perex.cz (Postfix) with ESMTP id E7FDE1038CA
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:38:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hskzqthgh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jiang zhe <zhe.jiang@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 04:25:18PM +0100, Takashi Iwai wrote:

> At Mon, 18 Feb 2008 16:22:01 +0100,
> Richard Lyons wrote:
> > 
> > On Mon, Feb 18, 2008 at 09:51:05AM +0800, Jiang zhe wrote:
> > 
[...]
> > > Your kernel is 2.6.17. Its alsa driver is too older.
[...]
> > 
> > It looks as though I have to wait to try kernel 2.6.24 as in debian
> > unstable.  When I have a fast internet connection one day, I shall try
> > this. It is not practical or affordable to upgrade over GPRS.
> 
> You can build alsa-driver modules externally.  It's more standard
> procedure for debugging sound problems.  Just configure and
> install as usual.  See alsa-driver/INSTALL for details.
> 
> In your case, maybe better to try alsa-driver daily snapshot tarball
> than 1.0.16.  See alsa-driver.project web page.

Oh, thanks.  Sounds intimidating, but I'll see if I can manage that.

ll it matter if I do it with the 2.6.17 rather than 2.6.18 kernel, as
the .18 flavour breaks ACPI on my box?

-- 
richard
