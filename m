Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B7B5267A79
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 07:15:10 +0100 (CET)
Date: Thu, 30 Nov 2017 11:44:43 +0530
From: Naveen M <naveen.m@intel.com>
Message-ID: <20171130061443.GA31069@nm-B85M-D3Hnaveen.m@intel.com>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
 <1510740463-21655-2-git-send-email-naveen.m@intel.com>
 <20171129123314.4x4giq4hk2ew2zol@sirena.org.uk>
 <20171130040204.GK32417@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171130040204.GK32417@localhost>
Subject: Re: [alsa-devel] [PATCH RESEND 1/2] ASoC: Intel: kbl: Remove option
 of choosing CH count based on pdata
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-ID: <alsa-devel@alsa-project.org>

On Thu, Nov 30, 2017 at 09:32:08AM +0530, Vinod Koul wrote:
> On Wed, Nov 29, 2017 at 12:33:14PM +0000, Mark Brown wrote:
> > On Wed, Nov 15, 2017 at 03:37:42PM +0530, Naveen Manohar wrote:
> > > Remove option of choosing channel count based on pdata for
> > > kbl_rt5663_max98927 machine driver.
> > > As User-space expects 4ch DMIC data and uses channel-map in ucm to
> > > figure-out the desired channel to use, Hence removing driver change
> > > to allow choosing channels.
> > 
> > To repeat my previous question which I don't seem to see a response to:
> > 
> > | Which userspace and are you sure there are no boards that only have two
> > | of the mics?
> 
> I am not sure why Naveen didn't respond, I will ask around.
> 
My Bad, my apologies to Mark.
I did try replying but message wasn't sent from my outbox which I'm noticing
today after vinod's mail to Mark.
Sorry about missing this, it's due to mutt configuration in linux that got
corrupted recently in my work-mac, making my replies for patches un-sent.

Regarding the Query:
As Vinod mentioned, I'm working on Chrome OS user-space stack that uses
customized audio server "CRAS".
These patches are verified on a board that has only 2 dmics.

Giving the control to CRAS, enables to select the desired dmic using
channel-map configuration in user-space.
Ex:Rear/Front mic selection for World & Front facing camera scenario 

> FWIW the userspace in question is CRAS. CRAS wants to manage MICs and would

> *know* how many MICs are on the board and would work with PCM data
> accordingly...
> 
> -- 
> ~Vinod

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
