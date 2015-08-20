From: "Fang, Yang A" <yang.a.fang@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer
 after period elapse occurs
Date: Thu, 20 Aug 2015 01:25:21 +0000
Message-ID: <0485FB02182A4744A8B06D69AB7BF8E718D72C4F@ORSMSX113.amr.corp.intel.com>
References: <1439791945-106012-1-git-send-email-yang.a.fang@intel.com>
 <20150817195555.GY10748@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718D71126@ORSMSX113.amr.corp.intel.com>
 <20150819003529.GO10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C160265139
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 03:25:24 +0200 (CEST)
In-Reply-To: <20150819003529.GO10748@sirena.org.uk>
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
> Sent: Tuesday, August 18, 2015 5:35 PM
> To: Fang, Yang A
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> dgreid@chromium.org; Nujella, Sathyanarayana;
> kevin.strasser@linux.intel.com; Sripathi, Srinivas; Iriawan, Denny; Jain,
> Praveen K; Koul, Vinod; Mirche, Dinesh
> Subject: Re: [PATCH] ASoC: Intel: Bsw: Read sst DSP DMA pointer after
> period elapse occurs
> 
> On Tue, Aug 18, 2015 at 05:33:33PM +0000, Fang, Yang A wrote:
> 
> > > > We should not read sst hw_ptr and pcm_delay in
> > > > sst_platform_pcm_pointer Since it will be ricky if
> > > > sst_platform_pcm_pointer is called while dsp is updating the
> > > > timestamp.Now read sst hw_ptr after period elapse interrupt occurs.
> 
> > > So I guess there's still some risk that we could run into problems
> > > here if we take too long to service the interrupt and/or the period
> > > is very short?  Is there anything we can do to improve that?
> 
> >  I think before and after the patch. There is no difference in term of
> > handling the period elapse interrupt . because before the patch
> > sst_period_elapsed calls the snd_pcm_period_elapsed which in turn
> > calling the sst_platform_pcm_pointer which calls the stream_read_tstamp.
> 
> I'm not sure I understand what the patch fixes then?  My concern is that
> we're just moving the timing around which changes but doesn't address the
> race condition.

We are seeing the issue during the long time playback.  
The ring_buffer_counter (part of snd_sst_tstamp  struct )supposes only increasing by the firmware  once firmware fetches  one period size of data.
 It will update the ring_buffer_counter in the mailbox and trigger a period elapse interrupt.  We have found the ring_buffer_counter got decreased 
during long time playback if we  call stream_read_tstamp to read mailbox  in sst_platform_pcm_pointer function.

There are two cases sst_platform_pcm_pointer will be getting called. One is called by sst_period_elapsed function.
 The second case is triggered by the userspace ioctl . The second case supposes reading the same case  ring_buffer_counter  value as last  read 
when period elapse interrupt  occurs . However we saw it somehow decreases.This causes audio stutter.
