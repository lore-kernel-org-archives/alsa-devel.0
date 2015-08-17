From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Mon, 17 Aug 2015 10:05:51 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D116C@SHSMSX101.ccr.corp.intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
 <20150814203428.GR10748@sirena.org.uk> <s5ha8ttypc1.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D04D0@SHSMSX101.ccr.corp.intel.com>
 <s5h37zkzk2x.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D056B@SHSMSX101.ccr.corp.intel.com>
 <20150815165147.GJ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CFEDE26061B
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 12:05:59 +0200 (CEST)
In-Reply-To: <20150815165147.GJ10748@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Sunday, August 16, 2015 12:52 AM

> On Sat, Aug 15, 2015 at 03:25:18PM +0000, Lin, Mengdong wrote:
> 
> > In addition, does "disable this API/ABI for 4.2" mean disabling all
> > topology features, or only some structures for v4.2?  But alsa-lib
> > already integrated this ABI version.
> 
> I'm suggesting not including this at all in the v4.2 release so we can continue
> to make changes, or perhaps just leaving the code there but making sure it
> can't be used as Takashi suggested.  alsa-lib hasn't released yet as far as I'm
> aware so we can continue to make changes there.

Hi Takashi/Mark,

After syncing with Liam, we hope to disable topology in the v4.2 release atm but leave the code there.

There may be topology ABI changes later and keeping backward compatibility would be difficult.

Sorry for the inconvenience.

Thanks
Mengdong

> 
> > I'm worried that If we have to add new fields to ABI structures, how
> > to keep the backward compatibility.
> 
> Right, it's tricky - there's a bunch of techniques like the versioning that's in the
> current structures but they all take work and effort.
