From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Fri, 31 Oct 2014 12:48:26 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B704DC6@SHSMSX101.ccr.corp.intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
 <20141029103053.GX18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DB3B22606AF
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:48:30 +0100 (CET)
In-Reply-To: <20141029103053.GX18557@sirena.org.uk>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

+ Liam.

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, October 29, 2014 6:31 PM

> > > Nothing ever stops the PLL - a set_bias_level() callback with a handler for
> _OFF.
> > > Otherwise we're wasting power.
> 
> > Can we introduce a power supply widget for the platform clock used as
> MCLK?
> > That widget can be added into the playback and capture path.
> > So when idle, the platform clock can be turn off and let the codec PLL
> > selects its internal low frequency clock only for jack detection. It's verified
> internally.
> 
> That should be fine also, it's just usually a bit more work to add all the routes
> for DAPM.
> 
> > Or we don't change the code at moment, until we upstream the platform
> > clock driver at first?
> 
> > Which way is better?
> 
> Well, currently the code to load the driver is also not upstream so may as well
> have the driver be what's wanted!  But it's not a massive deal, main thing
> would be to get everything done as part of initial upstreaming instead of
> having to come back and work on it again later.

Now we're working with Realtek to enable runtime PM on RT5672 codec driver.
With help of ACPI, 
- the codec will be in suspended to D3 when idle , switch to its internal clock, 
 and BIOS will turn off the platform clock output (MCLK) to save power.
- And when the codec resumes to D0, BIOS will turn on the clock at first. And 
 hw_params will make the codec use PLL and lock to MCLK again.

Thus the machine driver does not need to explicitly turn on/off the platform 
codec by itself.

Thanks
Mengdong
