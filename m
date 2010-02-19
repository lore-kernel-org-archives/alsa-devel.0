From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] oxygen: clean up. make precedence explicit
Date: Fri, 19 Feb 2010 23:08:41 +0300
Message-ID: <20100219200841.GF17130@bicker>
References: <4B7E4BD1.3040106@ladisch.de> <20100219101047.GB17130@bicker>
	<1266575610.31443.6.camel@thorin> <20100219112921.GC17130@bicker>
	<1266584951.31443.15.camel@thorin> <4B7EC93A.5010304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 92BB71037F3
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 21:09:00 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so36599eyh.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 12:08:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B7EC93A.5010304@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 19, 2010 at 06:24:10PM +0100, Clemens Ladisch wrote:
> Bernd Petrovitsch wrote:
> > On Fre, 2010-02-19 at 14:29 +0300, Dan Carpenter wrote:
> > > On Fri, Feb 19, 2010 at 11:33:30AM +0100, Bernd Petrovitsch wrote:
> > > Basically often when people write:
> > > 	if (!foo == bar) { ...
> > > 
> > > What they mean is:
> > > 	if (!(foo == bar)) { ...
> 
> But there are also cases where they mean what they've written.
> 
> > Ugh. The IMHO better way is 
> > 	if (foo != bar) { ...
> 
> In my case, the driver compares an "enabled" variable against a
> "disabled" one; negating the comparison operator would obfuscate the
> logic.
> 
> > > But if they really do mean the original code they could just write 
> > > this so it's clear to everyone: 
> > > 	if ((!foo) == bar) { ...
> 
> This is unnatural (especially in a simple example like this) because
> the parens haven't been needed at all before smatch.
> 
> 
> !foo==bar is always identical to !(foo==bar) for boolean values; to
> avoid false positives, you could output the warning only when the code
> is trying to manipulate non-boolean values.  IMO the message would be
> justified if it said "using suspicious boolean operations on non-boolean
> types".  (In fact, my driver uses types long and u8 in this expression,
> so I will clean it up.)
> 

Yup.  The check already takes the type into account.  Making chip->dac_mute
type bool would silence the message.

regards,
dan carpenter

> 
> Regards,
> Clemens
