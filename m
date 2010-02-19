From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] oxygen: clean up. make precedence explicit
Date: Fri, 19 Feb 2010 18:24:10 +0100
Message-ID: <4B7EC93A.5010304@ladisch.de>
References: <4B7E4BD1.3040106@ladisch.de> <20100219101047.GB17130@bicker>	
	<1266575610.31443.6.camel@thorin> <20100219112921.GC17130@bicker>
	<1266584951.31443.15.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EF6E8103958
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 18:24:12 +0100 (CET)
In-Reply-To: <1266584951.31443.15.camel@thorin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
List-Id: alsa-devel@alsa-project.org

Bernd Petrovitsch wrote:
> On Fre, 2010-02-19 at 14:29 +0300, Dan Carpenter wrote:
> > On Fri, Feb 19, 2010 at 11:33:30AM +0100, Bernd Petrovitsch wrote:
> > Basically often when people write:
> > 	if (!foo == bar) { ...
> > 
> > What they mean is:
> > 	if (!(foo == bar)) { ...

But there are also cases where they mean what they've written.

> Ugh. The IMHO better way is 
> 	if (foo != bar) { ...

In my case, the driver compares an "enabled" variable against a
"disabled" one; negating the comparison operator would obfuscate the
logic.

> > But if they really do mean the original code they could just write 
> > this so it's clear to everyone: 
> > 	if ((!foo) == bar) { ...

This is unnatural (especially in a simple example like this) because
the parens haven't been needed at all before smatch.


!foo==bar is always identical to !(foo==bar) for boolean values; to
avoid false positives, you could output the warning only when the code
is trying to manipulate non-boolean values.  IMO the message would be
justified if it said "using suspicious boolean operations on non-boolean
types".  (In fact, my driver uses types long and u8 in this expression,
so I will clean it up.)


Regards,
Clemens
