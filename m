From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes
	control
Date: Mon, 17 Aug 2015 01:33:11 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D0A78@SHSMSX101.ccr.corp.intel.com>
References: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
 <20150814191742.GJ10748@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D0537@SHSMSX101.ccr.corp.intel.com>
 <20150815161021.GH10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E5F56260535
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 03:33:16 +0200 (CEST)
In-Reply-To: <20150815161021.GH10748@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Sunday, August 16, 2015 12:10 AM

> On Sat, Aug 15, 2015 at 03:04:53PM +0000, Lin, Mengdong wrote:
> > > -----Original Message-----
> > > From: Mark Brown [mailto:broonie@kernel.org]
> 
> Please fix your mail client to word wrap within paragraphs, your messages are
> quite hard to read.  It also seems to be rewriting quoted material :/

Okay. Sorry for the inconvenience.

> > > Having two different classes of bespoke handlers like this both
> > > called bespoke handlers seems like it's going to lead to problems -
> > > either bringing the interfaces closer together or naming them in a
> > > way that clarifies their meaning seems better.  Instead of just
> > > calling them "bespoke handlers" we should probably just call them
> > > handlers for whatever kind of control they're for and probably bind
> > > them first rather than second so we're doing more specific to less specific
> handling.
> > > That way drivers can also have specific handling for things the
> > > topology data didn't anticipate they'd need it for which seems like it
> might come in handy.
> 
> > Are you suggesting that we bind bespoke handlers at first and then the
> > standard handlers?  Since the bespoke handlers means more
> > vendor-specific handling that need to be taken care at first.
> 
> Yes, that's what I'm suggesting.  Why would this mean any additional work?
> Either things have custom handlers or they don't...

Got it. Not additional work. I'll revise the patch.

Thanks
Mengdong
