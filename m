From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] soc: sgtl5000 uses regulator interfaces
Date: Sat, 5 Mar 2011 11:29:36 +0000
Message-ID: <20110305112936.GA30187@opensource.wolfsonmicro.com>
References: <20110304180027.20deb6c4.sfr@canb.auug.org.au>
 <20110304173357.23d36116.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110304173357.23d36116.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Zeng Zhaoming <zhaoming.zeng@freescale.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 04, 2011 at 05:33:57PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> sgtl5000 uses regulator interfaces, so make selecting it depend
> on REGULATOR.
> 
> sgtl5000.c:(.text+0x4ae33): undefined reference to `regulator_unregister'
> sgtl5000.c:(.text+0x4af41): undefined reference to `rdev_get_drvdata'
> sgtl5000.c:(.text+0x4b191): undefined reference to `regulator_register'

Since the regulator on the device is optional this isn't the best fix,
the code should be updated to support building without regulator.  
