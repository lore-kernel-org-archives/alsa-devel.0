From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Alsa Driver on Coldfire
Date: Fri, 18 Apr 2008 18:11:52 +0100
Message-ID: <20080418171152.GA14011@opensource.wolfsonmicro.com>
References: <op.t9swu605hpbl6d@derby> <s5hwsmvea38.wl%tiwai@suse.de>
	<20080418112340.GB19457@rakim.wolfsonmicro.main>
	<op.t9tctqwjhpbl6d@derby>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14C68246F8
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 19:11:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <op.t9tctqwjhpbl6d@derby>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Dunn <sdunn@mpc-data.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 04:47:40PM +0100, Simon Dunn wrote:
> On Fri, 18 Apr 2008 12:23:41 +0100, Mark Brown 

> excluded.  Oh and thanks for the tip re the system on chip, I'll have
> a look into that though the kernel version we're working with is
> 2.6.10 and doesn't include it 'off the shelf'.

> Can't imagine it would be too difficult to merge across unless anyone
> knows different?

Tedious more than hard - there was a change in the ALSA APIs from using
typedefs to using 'struct foo' which creates a lot of code churn but is
not at all difficult to deal with.  Other than that things should be
pretty straightforward.
