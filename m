From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Thu, 15 Sep 2011 10:16:20 -0500
Message-ID: <4E7216C4.1090902@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<20110915132154.GF7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A45410384C
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 17:16:59 +0200 (CEST)
In-Reply-To: <20110915132154.GF7988@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Sep 13, 2011 at 12:59:35PM -0500, Timur Tabi wrote:
> 
>> -	iface = 0;
>> -
> 
> Random stylistic changes like this make review harder, especially when
> they're not mentioned in the changelog. 

This is not a random stylistic change.  My patch changes the way iface is
calculated.  Therefore, removing an unnecessary pre-initialization of iface is
both obvious and expected.

The "iface = 0" line is used in the original code because the driver did not
have a "default" case for the "switch" statement.  Since I added a default case,
there was no need to pre-initialize iface anymore.

If I had left that line in the driver, someone would have complained that I'm
pre-initializing iface unnecessarily.

> In this case it's not clear
> from the diff alone that there are no other places where iface gets
> written to

Ok, so that means that you need to look at the original code in order to
understand the change completely.  What's wrong with that?  I just don't see how
this is a valid criticism for any patch.

> An important aspect of review is checking that the change being made
> actually do what they're supposed to do, unexpected additional stuff is
> a red flag - you have to work out if it's something the sender meant to
> include, what it's supposed to do and if it's a good idea.

Again, I just don't understand this complaint of my patch.  I've carefully read
your email, and I re-examined my patch and the original code, and I still don't
think that there's anything wrong with the patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
