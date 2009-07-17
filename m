From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Add possibility to control the
	GPIO_STATUS shift
Date: Fri, 17 Jul 2009 11:32:53 +0100
Message-ID: <20090717103253.GF3439@rakim.wolfsonmicro.main>
References: <200907171001.16889.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4D271038DE
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 12:32:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907171001.16889.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 10:01:16AM +0200, Marek Vasut wrote:

> This patch allows tweaking the behaviour of GPIO_STATUS register
> shift quirk that's in wm97xx-core. The problem with GPIO_STATUS 
> register being shifted by one doesn't appear on all hardware it 
> seems and causes problems with accelerated touchscreen drivers on
> Palm hardware. Therefore an accelerated touchscreen driver can select
> if the shift is/isn't happening on the hardware.                     

Again, this isn't an ALSA patch.

I've done some checking internally and I'm very suspicous that what's
going on here is actually the masking of some other bug elsewhere in the
system.  Which CPU are the systems you're observing this on using?
There is at least one special case in the current code for GPIO register
readbacks in the PXA AC97 driver code and there have been a number of
interoperabilty issues in that area...
