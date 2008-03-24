From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Mon, 24 Mar 2008 13:57:03 +0000
Message-ID: <20080324135703.GA26283@flint.arm.linux.org.uk>
References: <47E7A0A8.3010200@oliford.co.uk>
	<20080324134231.GA30281@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6C1AE103858
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 14:57:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080324134231.GA30281@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>, linux-arm-kernel@lists.arm.linux.org.uk, alex.meakins@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 24, 2008 at 01:42:32PM +0000, Mark Brown wrote:
> On Mon, Mar 24, 2008 at 12:38:00PM +0000, Oliver Ford wrote:
> > but am not sure. Compiling either gives the warning "'pxa_set_cken' is 
> > deprecated". I suspect calling this won't work for the pxa310 since it's 
> 
> This is also fixed in the patches currently queued in the ARM tree -
> the drivers have been converted to use the clk_() API.
> 
> > clocks are different, but given that I'm booting linux from windows 
> > (which will leave the clock on) and don't particularly care about 
> > suspend/resume, should not being able to switch it off be a problem?
> 
> The cken calls should actually work fine.

The pxa_set_cken() will not do the right thing for PXA3xx CPUs, which is
why that interface is deprecated.  If you're building for PXA3 CPUs and
you get warnings about pxa_set_cken() that's a sure sign that something's
wrong.
