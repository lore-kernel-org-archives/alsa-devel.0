From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 01/13] OMAP: hwmod: Add member 'name' to omap_hwmod_addr_space
 struct
Date: Wed, 9 Feb 2011 14:14:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102091413340.21991@utopia.booyaka.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com> <1296485437-12806-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1296485437-12806-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: khilman@deeprootsystems.com, tony@atomide.com, Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, charu@ti.com, shubhrajyoti@ti.com, b-cousson@ti.com, p-basak2@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, 31 Jan 2011, Kishon Vijay Abraham I wrote:

> Adds a structure member 'name' to 'omap_hwmod_addr_space' structure.
> The drivers can use platform_get_resource_byname() to get resource of
> type 'IORESOURCE_MEM' by name so that it need not rely on the order to get
> the proper resource.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com> -- although, please update the 
patch description as Kevin requested.

- Paul
