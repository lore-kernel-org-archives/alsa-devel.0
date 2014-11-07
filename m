From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/4] ASoC:rt5670:Add runtime PM support
Date: Fri, 7 Nov 2014 09:24:54 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B70D607@SHSMSX101.ccr.corp.intel.com>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
 <20141106055525.GN8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5262610B1
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 10:27:14 +0100 (CET)
In-Reply-To: <20141106055525.GN8509@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "bardliao@realtek.com" <bardliao@realtek.com>
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "flove@realtek.com" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, November 06, 2014 1:55 PM
> To: bardliao@realtek.com

> > +static int rt5670_runtime_resume(struct device *dev) {
> > +	return 0;
> > +}
> 
> This should be undoing the change done on suspend otherwise we'll be stuck
> on the internal clock after resuming.  Alternatively if something will undo that
> elsewhere then presumably we don't need to use runtime PM to select the
> internal clock anyway?

Is it okay to restore default sysclock setting is runtime_resume ops?

The codec sysclk source is MCLK (PLL is powered down) after boot by default.
We can also apply this when runtime resuming.

On Intel CherryTrail/Braswell platform, the BIOS will always restore MCLK when
the codec resumes from D3 to D0. So it's safe to use MCLK as source for codec 
sysclk in runtime_resume ops. And later hw_params ops can further configure 
sysclk source and PLL for active audio streaming.

Thanks
Mengdong
