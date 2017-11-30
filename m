From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
Date: Thu, 30 Nov 2017 09:32:08 +0530
Message-ID: <20171130040204.GK32417@localhost>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
 <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 914E9266E70
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 04:58:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
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
Cc: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 29, 2017 at 12:33:14PM +0000, Mark Brown wrote:
> On Wed, Nov 15, 2017 at 03:37:42PM +0530, Naveen Manohar wrote:
> > Remove option of choosing channel count based on pdata for
> > kbl_rt5663_max98927 machine driver.
> > As User-space expects 4ch DMIC data and uses channel-map in ucm to
> > figure-out the desired channel to use, Hence removing driver change
> > to allow choosing channels.
> 
> To repeat my previous question which I don't seem to see a response to:
> 
> | Which userspace and are you sure there are no boards that only have two
> | of the mics?

I am not sure why Naveen didn't respond, I will ask around.

FWIW the userspace in question is CRAS. CRAS wants to manage MICs and would
*know* how many MICs are on the board and would work with PCM data
accordingly...

-- 
~Vinod
