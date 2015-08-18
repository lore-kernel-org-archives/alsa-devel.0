From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
 after period elapse occurs
Date: Tue, 18 Aug 2015 17:33:33 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718D71126@ORSMSX113.amr.corp.intel.com>
References: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
 <20150817195555.GY10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EB5632619D7
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 19:33:36 +0200 (CEST)
In-Reply-To: <20150817195555.GY10748@sirena.org.uk>
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
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, "Mirche,
 Dinesh" <dinesh.mirche@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Iriawan, Denny" <denny.iriawan@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>, "dgreid@chromium.org" <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, August 17, 2015 12:56 PM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; Sripathi, Srinivas; Iriawan, Denny; Jain,
> Praveen K; Koul, Vinod; Mirche, Dinesh
> Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer after
> period elapse occurs
> 
> On Sun, Aug 16, 2015 at 11:12:25PM -0700, yang.a.fang@intel.com wrote:
> 
> > We should not read sst hw_ptr and pcm_delay in
> > sst_platform_pcm_pointer Since it will be ricky if
> > sst_platform_pcm_pointer is called while dsp is updating the
> > timestamp.Now read sst hw_ptr after period elapse interrupt occurs.
> 
> So I guess there's still some risk that we could run into problems here if we
> take too long to service the interrupt and/or the period is very short?  Is
> there anything we can do to improve that?
Hi Mark,
 I think before and after the patch. There is no difference in term of 
 handling the period elapse interrupt . because before the patch 
 sst_period_elapsed calls the snd_pcm_period_elapsed which in turn 
 calling the sst_platform_pcm_pointer which calls the stream_read_tstamp.
