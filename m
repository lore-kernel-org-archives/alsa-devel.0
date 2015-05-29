From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH v2 1/3] ASoC: max98090: read micbias from
	device property
Date: Fri, 29 May 2015 17:37:45 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718CFB9F6@ORSMSX113.amr.corp.intel.com>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
 <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
 <20150529095858.GM21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A4A260714
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 19:37:47 +0200 (CEST)
In-Reply-To: <20150529095858.GM21577@sirena.org.uk>
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
To: 'Mark Brown' <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, May 29, 2015 2:59 AM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; Sripathi, Srinivas; Iriawan, Denny; Jain,
> Praveen K; Koul, Vinod
> Subject: Re: [PATCH v2 1/3] ASoC: max98090: read micbias from device
> property
> 
> On Thu, May 28, 2015 at 11:00:46AM -0700, yang.a.fang@intel.com wrote:
> 
> >  - maxim,dmic-freq: Frequency at which to clock DMIC
> >
> > +- maxim,micbias: Micbias voltage applies to the analog mic
> 
> This needs to be more specific about what the value is - it looks like it's the
> value to be written into a particular register?
> 
Yes it is written into the register. I will put more information

> > +	err = device_property_read_u32(codec->dev, "maxim,micbias",
> &micbias);
> > +	if (err || micbias < M98090_MBVSEL_2V2  || micbias >
> M98090_MBVSEL_2V8)
> > +		micbias = M98090_MBVSEL_2V8;
> 
> We should be logging an error if we read and out of range value here - it's
> expected that the value might be missing but if we manage to read
> something and it's invalid we should say so rather than silently ignore it.
Okay, will put log if out of range .
