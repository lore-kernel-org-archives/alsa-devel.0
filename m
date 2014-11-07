From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/4] ASoC:rt5670:Add runtime PM support
Date: Fri, 7 Nov 2014 14:33:24 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B70DA8B@SHSMSX101.ccr.corp.intel.com>
References: <1415247834-14278-1-git-send-email-bardliao@realtek.com>
 <20141106055525.GN8509@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B70D607@SHSMSX101.ccr.corp.intel.com>
 <20141107094419.GX8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D07326575E
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 15:34:21 +0100 (CET)
In-Reply-To: <20141107094419.GX8509@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "bardliao@realtek.com" <bardliao@realtek.com>, "flove@realtek.com" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, November 07, 2014 5:44 PM

> > > > +static int rt5670_runtime_resume(struct device *dev) {
> > > > +	return 0;
> > > > +}
> 
> > > This should be undoing the change done on suspend otherwise we'll be
> > > stuck on the internal clock after resuming.  Alternatively if
> > > something will undo that elsewhere then presumably we don't need to
> > > use runtime PM to select the internal clock anyway?
> 
> > Is it okay to restore default sysclock setting is runtime_resume ops?
> 
> Yes, that's fine of course - I'm just assuming that this works already so
> presumably there is some restore code somewhere already that should be
> removed?

Bard verified the patch on a Tegra platform and I did on a Braswell platform.
On Braswell, the codec keeps using the internal clock after runtime resumed
until machine driver select its sysclk source to PLL in hw_param ops. 
No other restore clk restore code.

Since other machine driver can have different behavior, so it seems better to 
restore default clk settings when runtime resumed, as after boot. And I can
test this next Monday.

Thanks
Mengdong
