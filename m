From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 19 Mar 2015 14:31:58 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BDA3F0@SHSMSX101.ccr.corp.intel.com>
References: <5509D4D4.6030000@linux.intel.com>
 <1426756559.7258.22.camel@loki> <s5h3851t6xx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 115AA260584
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 15:32:04 +0100 (CET)
In-Reply-To: <s5h3851t6xx.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "Lu, Han" <han.lu@intel.com>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, March 19, 2015 10:10 PM
> To: Liam Girdwood
> Cc: Tanu Kaskinen; alsa-devel@alsa-project.org; Arun Raghavan; Lu, Han;
> Mark Brown; Jie, Yang
> Subject: Re: Separate input and output jacks for one UCM device?
> 
> At Thu, 19 Mar 2015 09:15:59 +0000,
> Liam Girdwood wrote:
> >
> > On Wed, 2015-03-18 at 21:41 +0200, Tanu Kaskinen wrote:
> > > Hi Liam and alsa-devel,
> > >
> >
> > I've added a few others on the CC that would be interested.
> >
> > > My understanding is that a UCM device can represent a thing that has
> > > both input and output (I don't particularly like that, but it's too
> > > late to complain).
> >
> > Yes, but it can also represent simplex devices too e.g.
> > "Headset-Speakers" and "Headset-Mic". There are not any hard rules
> > here, but most examples are using duplex devices as historically UCM
> > came from the phone ecosystem use cases.
> >
> > > How likely do you think that there are or there will be some drivers
> > > that expose separate input and output jack kcontrols for a headset
> > > jack, to differentiate between headphones/headset/microphone? My
> > > understanding is that jack kcontrols store only booleans, so there's
> > > no way to distinguish between headphones and a headset with just one
> kcontrol.
> > >
> >
> > This sounds like we need to extend the jack kcontrol so that we can
> > differentiate between Headphones and Headset unless the kcontrol
> > naming was intended to differentiate and define the jack type ?
> 
> Yeah, that's what we really need to face seriously now to.
> Keyon is working on merging input and kctl jacks, and this is the biggest
> problem that has to be sorted out.
> 
> As far as I understand correctly, so far ASoC drivers also report headset as
> boolean (the bits are multiple, but reports are either zero or N bits).  So, we
> agreed on creating boolean "Headset" kctls.
> 
> One option is to provide multiple boolean kctls ("Headset Mic Jack").
> Another option is to allow enum type for kctl jacks.  Or, yet another
> alternative is to provide an enum ctl (e.g. "Headset Jack Type") in addition to
> a boolean kctl ("Headset Jack").  There can be other ways, too...
[Keyon] I have another concern, should app(e.g. pulseaudio) also need be
able to handle different index with same "Headset Jack" kctl name? or we
should register them as "Headset Jack N Mic" (n=0, 1, 2, ...)?
> 
> 
> Takashi
