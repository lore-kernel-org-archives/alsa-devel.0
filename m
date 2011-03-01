From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove module probe announcements
 from CODEC drivers
Date: Tue, 1 Mar 2011 20:21:54 +0000
Message-ID: <20110301202153.GJ9662@opensource.wolfsonmicro.com>
References: <1299010455-31934-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4D6D5445.3010202@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1E5D2412E
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 21:21:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D6D5445.3010202@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 01, 2011 at 02:17:09PM -0600, Timur Tabi wrote:

> Can I get a justification for this change?  On my boards, the CS4270 driver is
> compiled in-kernel, not as a module, and so when the kernel boots, the driver
> announces itself when it's loaded.  I like this a lot, which is why I always put
> a pr_info() in the __init function of my modules.

It's rather chatty, especially where one has unused modules compiled
into the kernel, and displayed on the (usually slow serial) console by
default.  Having lots of drivers announce themselves in this fashion
gets rather spammy, at the minute only a very small proportion do so.
As a matter of policy Linux drivers generally don't do this.

Printing a message when the driver is actually binding to hardware can
be useful, mainly if it's something like announcing the device revision,
but doing so at module load isn't really conveying anything meaningful.
