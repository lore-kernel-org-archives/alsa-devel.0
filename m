From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: no-pcm (backend) error propagation
Date: Wed, 27 Feb 2013 09:43:52 -0600
Message-ID: <512E29B8.8050708@linux.intel.com>
References: <190351B32828744FBA3BD9565204D27B01CA3AF2@NA-MBX-03.mgc.mentorg.com>
 <1361953433.28121.33.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4532650DB
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2013 16:44:05 +0100 (CET)
In-Reply-To: <1361953433.28121.33.camel@vega>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "Frkuska, Joshua" <Joshua_Frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org


> It was originally intended that any underrun / overrun issues in a BE
> DAI would be handled internally by the audio DSP (and this worked well
> with the OMAP4 ABE). However, it is probably a good a idea to have a
> better mechanism for reporting BE xrun issues up the stack to the host
> CPU side too.
>
> Currently the FE PCM xrun mechanism and FE pointer() callback could be
> used by the host to get the size of any FE:BE underrun/overrun. This
> isn't ideal and wont work when there can be multiple BEs for a FE.
>
> It looks like some new code is required here to get this working
> correctly for BEs.


My view is that that underruns at the DSP level are fatal anyway, and 
that they a) should be avoided with proper real-time designs and b) they 
should be logged as error conditions to debug should they occur, not be 
tied to a FE. It would be really complicated to add code to 
back-propagate the errors, and if you have mixing/routing what 
individual FEs would do when this is a system error really.
-Pierre
