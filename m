From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Move capture PCM pin to PCM0
	for Broadwell
Date: Fri, 28 Nov 2014 13:40:23 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B73294@SHSMSX101.ccr.corp.intel.com>
References: <1417173643-25331-1-git-send-email-yang.jie@intel.com>
 <20141128113958.GI7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A9BC260467
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 14:40:33 +0100 (CET)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


Hi Mark,

Please ignore my previous mail. Liam comment that it's better to update the haswell machine driver at the same time.

Will resend v2 for the patch.

Thanks,
~Keyon


> -----Original Message-----
> From: Jie, Yang
> Sent: Friday, November 28, 2014 8:00 PM
> To: 'Mark Brown'
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: RE: [PATCH] ASoC: Intel: Move capture PCM pin to PCM0 for Broadwell
> 
> 
> Hi Mark,
> 
> Thanks for reviewing. Seems it need to be applied after commit ' [PATCH] ASoC:
> Intel: Correct the xmax volume' is accepted.
> I can apply it base on the commit
> 1e2f1a5f8c4826e3d09fd67dec5f09e64b25c0d5.
> 
> Regards,
> ~Keyon
> 
> 
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]
> > Sent: Friday, November 28, 2014 7:40 PM
> > To: Jie, Yang
> > Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> > Subject: Re: [PATCH] ASoC: Intel: Move capture PCM pin to PCM0 for
> > Broadwell
> >
> > On Fri, Nov 28, 2014 at 07:20:43PM +0800, Jie Yang wrote:
> > > Move capture PCM pin from PCM4 to PCM0 for Broadwell.
> > > This will allow us to integrate with pulseaudio better for usually
> > > default device is set to 0.
> >
> > This doesn't apply, please check and resend.
