From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 2/5] ASoC: Davinci: McASP: add device tree
 support for McASP
Date: Thu, 23 Aug 2012 07:56:44 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA68834@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-3-git-send-email-gururaja.hebbar@ti.com>
 <20120817224131.GJ18871@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id EE569265CA8
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 09:56:56 +0200 (CEST)
In-Reply-To: <20120817224131.GJ18871@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Ujfalusi,
 Peter" <peter.ujfalusi@ti.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 18, 2012 at 04:11:32, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:02PM +0530, Hebbar, Gururaja wrote:
> 
> > +- op-mode : I2S/DIT ops mode.
> 
> This would normally be part of the machine binding since it needs to be
> applied to both ends of the link.

But in case of McASP driver, it is used when calling snd_soc_register_dai()
To pick the proper dai depending on the McASP operation mode.


> When adding it could you come up with
> a generic binding for this in terms of the current ASoC DAI paremeters
> please?  That way we'll be able to have other machine drivers be
> consistent with this one.

Will look into this once I complete the initial DT porting.

> 
> > +- tdm-slots : Slots for TDM operation.
> 
> This would normally also be a machine driver thing though it's less
> normal to need to configure this on both ends.
> 

This parameter is used by McASP hardware controller for managing slots and
Isn't related to any machine modules.

Regards, 
Gururaja
