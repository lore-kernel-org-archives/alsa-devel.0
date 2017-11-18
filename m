From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/5 v2] ASoC: mt8173: Fix
 platform_get_irq's error checking
Date: Sat, 18 Nov 2017 08:18:06 +0000
Message-ID: <20171118081805.GT31757@n2100.armlinux.org.uk>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510982440.git.arvind.yadav.cs@gmail.com>
 <f683092949c0a6195b09ebbeb690e358094a0506.1510982440.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id E77892672A8
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 09:18:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f683092949c0a6195b09ebbeb690e358094a0506.1510982440.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 18, 2017 at 10:57:52AM +0530, Arvind Yadav wrote:
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.

IRQ 0 is not a valid interrupt.  The correct test here is <= 0.
Please rework your patches for this.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
