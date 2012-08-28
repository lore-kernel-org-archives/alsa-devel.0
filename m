From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Re: [PATCH V2 5/6] ASoC: Davinci: machine: Add device
	tree binding
Date: Tue, 28 Aug 2012 10:19:56 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA6C7AF@DBDE01.ent.ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
 <1346074004-22172-6-git-send-email-gururaja.hebbar@ti.com>
 <20120827181939.GX4339@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 034FA265FF5
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 12:20:05 +0200 (CEST)
In-Reply-To: <20120827181939.GX4339@opensource.wolfsonmicro.com>
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
 Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood,
 Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 27, 2012 at 23:49:40, Mark Brown wrote:
> On Mon, Aug 27, 2012 at 06:56:43PM +0530, Hebbar, Gururaja wrote:
> > Device tree support for tlv320aic3x CODEC driver
> 
> Not really for the CODEC - this is a machine driver.
> 
> > +- dai-data		: A list of DAI data used by SOC code to register
> > +			  DAI, Codecs platform.
> > +			  The string index "should" be as shown below.
> > +dai-data =
> > +"<DAI Name>", 		"<DAI Stream Name>",
> > +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> > +"<evm ops required (evm_ops or evm_spdif_ops)>";
> 
> What do these different ops do - how would the user figure it out or if
> they're needed at all?


Ok. I will correct and send.

Since other patches are accepted. I will send only this patch.
> 


Regards, 
Gururaja
