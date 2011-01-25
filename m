From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 2/4] OMAP4: hwmod: add entries for DMIC driver
Date: Tue, 25 Jan 2011 16:54:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101251654290.16671@utopia.booyaka.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com> <1295992862-6154-3-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1295992862-6154-3-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 25 Jan 2011, David Lambert wrote:

> From: Benoit Cousson <b-cousson@ti.com>
> 
> Adds HWMOD entries for the OMAP DMIC driver and creates
> a platform device.  The HWMOD entires define the system
> resource requirements for the drvier such as DMA addresses, channels,
> and IRQ's.  Placing this information in the HWMOD database allows
> for more generic drivers to be written and having the specific
> implementation details defined in HWMOD.
> 
> Signed-off-by: David Lambert <dlambert@ti.com>

This should have Benoit's Signed-off-by: also.


- Paul
