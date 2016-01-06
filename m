From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 03/13] ALSA: hdac: Add support for hda
 DMA Resume capability
Date: Wed, 6 Jan 2016 14:57:18 +0530
Message-ID: <20160106092718.GA11778@localhost>
References: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
 <1450431729-27259-4-git-send-email-vinod.koul@intel.com>
 <20160104055715.GD2940@localhost>
 <20160105155108.GE6588@sirena.org.uk>
 <s5hsi2brsf7.wl-tiwai@suse.de> <20160106091820.GQ2940@localhost>
 <s5hoaczrrtc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D92D5260417
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 10:24:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hoaczrrtc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 06, 2016 at 10:16:31AM +0100, Takashi Iwai wrote:
> On Wed, 06 Jan 2016 10:18:21 +0100,
> Vinod Koul wrote:
> > 
> > On Wed, Jan 06, 2016 at 10:03:24AM +0100, Takashi Iwai wrote:
> > > On Tue, 05 Jan 2016 16:51:08 +0100,
> > > Mark Brown wrote:
> > > > 
> > > > On Mon, Jan 04, 2016 at 11:27:15AM +0530, Vinod Koul wrote:
> > > > > On Fri, Dec 18, 2015 at 03:11:59PM +0530, Vinod Koul wrote:
> > > > 
> > > > > > Skylake sports new capability of DMA resume, DRSM where we can
> > > > > > resume the DMA. This capability is defined by presence of
> > > > > > AZX_DRSM_CAP_ID.
> > > > 
> > > > > Can you please ACK this and path 4, 5 and 6 of this series, as they are
> > > > > on sound/hda/. I think Mark is waiting on that..
> > > > 
> > > > Yes.
> > > 
> > > Sorry for the late reply, as I've been on vacation.
> > > Feel free to take my ack:
> > > 
> > > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Thanks Takashi
> > 
> > Can you please ACK the next three patches as well, they are
> > on HDA too
> 
> Oh I meant for the series.

Much better then, Thanks :)

-- 
~Vinod
