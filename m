From: Richard Lyons <richard@the-place.net>
Subject: Re: unable to get alsa configured on Acer Aspire 1640Z
Date: Mon, 18 Feb 2008 16:22:01 +0100
Message-ID: <20080218152156.GA3471@mulinocarletti.com>
References: <20080217171832.GI7750@mulinocarletti.com>
	<1203299465.3308.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tallyho.bytemark.co.uk (tallyho.bytemark.co.uk [80.68.81.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 28D5B1038C6
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:21:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203299465.3308.4.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 09:51:05AM +0800, Jiang zhe wrote:

> On Mon, 2008-02-18 at 01:18 +0800, Richard Lyons wrote:
> > Hi,
> > 
> > I hope this is the right place to report this.
> > 
> > Computer: laptop Acer Aspire 1640Z
> > 
> > distro: Debian etch
> > kernel: 2.6.17
[...]
> >     hda_codec: Unknown model for ALC882, trying auto-probe from
> > BIOS...
> > 
> > but alsamixer shows:
> >     Card: HDA Intel
> >     Chip: Realtek ALC883
> > at the top.
> > 
> > There seems to be uncertainty about which model number, 882 or 883.
> 
> Your kernel is 2.6.17. Its alsa driver is too older.
> It didn't provide patch_alc883 for ALC883 codec, but used the
> patch_alc882 for it.  AND there is no "model acer" in it.

I have tried with the latest kernel in debian etch (2.6.18) This gives
same error but with correct model number, ie
   hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
when trying to load either model=acer or acer-aspire

It looks as though I have to wait to try kernel 2.6.24 as in debian
unstable.  When I have a fast internet connection one day, I shall try
this. It is not practical or affordable to upgrade over GPRS.

Thankyou for the suggestion.

-- 
richard
