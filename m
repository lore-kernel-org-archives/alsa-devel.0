From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 2/3] ASoC: TWL4030: Add AVADC Clock Priority
Date: Fri, 19 Jun 2009 12:57:39 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E3543F5CE@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31D@dlee04.ent.ti.com>
	<20090619100016.GE5270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 37FCB245CC
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 19:57:46 +0200 (CEST)
In-Reply-To: <20090619100016.GE5270@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

> > +/* AVADC clock priority */
> > +static const char *twl4030_avadc_clk_priority_texts[] = {
> > +	"Voice high priority", "Audio high priority"
> > +};
> > +

> It'd probably be better to say "Hifi" (or whatever spelling 
> the rest of the driver uses) rather than "Audio" here.  Audio 
> is a bit confusing since obviously the voice data is audio 
> data too, it's just a different path through the CODEC with 
> different characteristics.  The same thing has been done 
> elsewhere in the driver.

Agree, "HiFi" is being used in codec DAI definition so I'll
use that too.

I'll wait for Peter's comments before resending the patch.

Thanks,
Misa
