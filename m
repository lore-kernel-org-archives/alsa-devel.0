From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 5/5] ASoC: tlv320aic3x: Add device tree
	bindings
Date: Wed, 22 Aug 2012 09:26:36 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA64BA4@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
 <20120817224512.GL18871@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BC36D2660ED
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 11:26:44 +0200 (CEST)
In-Reply-To: <20120817224512.GL18871@opensource.wolfsonmicro.com>
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

On Sat, Aug 18, 2012 at 04:15:13, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:05PM +0530, Hebbar, Gururaja wrote:
> 
> > +- gpio-reset - <int> -  gpio pin number used for codec reset
> 
> This should be a standard DT GPIO reference by phandle like:
> 
> 	gpio = <&gpio1 16 0>;

I will correct in V2

> 
> There's quite a few examples in tree.
> 
> Otherwise this looks good.
> 

Thanks for all the reviews.

Regards, 
Gururaja
