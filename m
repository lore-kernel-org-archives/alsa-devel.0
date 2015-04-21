From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v6 4/6] ASoC: jack: create kctls according
 to jack pins info
Date: Tue, 21 Apr 2015 01:16:59 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A905513676@SHSMSX101.ccr.corp.intel.com>
References: <1429351460-15932-1-git-send-email-yang.jie@intel.com>
 <1429351460-15932-5-git-send-email-yang.jie@intel.com>
 <20150420212031.GS14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2252605EC
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 03:18:33 +0200 (CEST)
In-Reply-To: <20150420212031.GS14892@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, April 21, 2015 5:21 AM
> To: Jie, Yang
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com
> Subject: Re: [PATCH v6 4/6] ASoC: jack: create kctls according to jack pins info
> 
> On Sat, Apr 18, 2015 at 06:04:18PM +0800, Jie Yang wrote:
> > In the new jack kctls design, we can create kctls according to pins
> > info:
> >
> > 1. during jack creating, snd_jack_new() with NULL jack_kctl; 2. for
> > each pin, call snd_jack_add_kctls() to add one kctl (it will call
> > snd_ctl_add() to add kctl to card);
> 
> I'm a little confused why this isn't done by the jack core?
 
The kctl creating and adding to jack is actually done by the jack core(inside
snd_jack_add_kctls()).

Mark, do you mean that you prefer doing this inside snd_jack_new()?

For we may need create multiple kctls for a jack, and I found we can reuse
the pins' info for those kctls' creating. 

For example, in broadwell.c, the jack broadwell_headset have 2 pins:
"Mic Jack" and "Headphone Jack", then 2 kctls with same names will be
created, and they are visible for PA, can be switched on/off by PA separately.

~Keyon
