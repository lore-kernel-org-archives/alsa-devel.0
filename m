From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH v9 0/7] ALSA: jack: Refactoring for jack
	kctls
Date: Fri, 24 Apr 2015 04:37:45 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A90551FDC7@SHSMSX101.ccr.corp.intel.com>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
 <s5h8udjko4m.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90551F692@SHSMSX101.ccr.corp.intel.com>
 <20150423181822.GA22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EB3CF260440
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 06:37:56 +0200 (CEST)
In-Reply-To: <20150423181822.GA22845@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tanu.kaskinen@linux.intel.com" <tanu.kaskinen@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, April 24, 2015 2:18 AM
> To: Jie, Yang
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Girdwood, Liam R;
> tanu.kaskinen@linux.intel.com
> Subject: Re: [PATCH v9 0/7] ALSA: jack: Refactoring for jack kctls
> 
> On Thu, Apr 23, 2015 at 01:45:07PM +0000, Jie, Yang wrote:
> 
> > Hi, Mark, per my understanding, we didn't create specific kcontrols
> > for each ASoC jack, now, my new change reuse the jack pins' info to
> > create these kcontrols, which can be seen and controlled from upper
> > layer (e.g. PA).
> 
> I have not been keeping up with this series because it's quite large and there
> have been many revisions in a short period of time, along with a large
> number of other substantial patch serieses from your colleagues.
 
I can imagine and understand that. Care yourself, Mark. :)

To simplify it, let me summarize it:
only the patch 5 in the series ([PATCH v9 5/7] ASoC: jack: create kctls according
to jack pins info) change ASoC code, when looking into it, you can find only one
line is added:
+	snd_jack_add_new_kctl(jack->jack, pins[i].pin, pins[i].mask);

So the patch will create extra kcontrols for ASoC jack, comparing to the current
upstream code.

Thanks,
~Keyon
