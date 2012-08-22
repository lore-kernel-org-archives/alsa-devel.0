From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH 4/5] ASoC: Davinci: machine: Add device
	tree binding
Date: Wed, 22 Aug 2012 11:35:11 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA658C7@DBDE01.ent.ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-5-git-send-email-gururaja.hebbar@ti.com>
 <20120817224327.GK18871@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 727C02663D8
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 13:35:17 +0200 (CEST)
In-Reply-To: <20120817224327.GK18871@opensource.wolfsonmicro.com>
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

On Sat, Aug 18, 2012 at 04:13:28, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:04PM +0530, Hebbar, Gururaja wrote:
> 
> > +- ti,codec-clock : The Codec Clock from the board
> 
> I think this is the clock rate?  Please specify it more specifically.

I will correct it in v2.

> 
> > +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> > +"<evm ops required, evm_ops or evm_spdif_ops>";
> 
> Please be more specific as to what these actually do - consider the user
> who is reading the bindings with a view to implementing them for their
> board, or writing drivers for another OS.

Will add more detail in V2

> 


Regards, 
Gururaja
