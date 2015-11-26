From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/7] ASoC: Intel: Skylake: Add Resume
 capability in PCM info.
Date: Thu, 26 Nov 2015 14:26:01 +0530
Message-ID: <20151126085601.GJ25173@localhost>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
 <1448297789-6524-2-git-send-email-vinod.koul@intel.com>
 <s5hsi3wblmn.wl-tiwai@suse.de> <20151124024449.GV25173@localhost>
 <s5hegfgaq28.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 73CCD2665AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 09:52:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hegfgaq28.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2015 at 07:07:11AM +0100, Takashi Iwai wrote:
> On Tue, 24 Nov 2015 03:44:49 +0100,
> Vinod Koul wrote:
> > 
> > On Mon, Nov 23, 2015 at 07:45:20PM +0100, Takashi Iwai wrote:
> > > On Mon, 23 Nov 2015 17:56:23 +0100,
> > > Vinod Koul wrote:
> > > > 
> > > > From: Jeeja KP <jeeja.kp@intel.com>
> > > > 
> > > > This patch adds pcm capability to support Resume.
> > > 
> > > The flag indicates that the driver is capable of the full resume --
> > > i.e. it must resume everything at the exactly same point to be
> > > suspended.  Is it really the case?
> > > 
> > > If it's not and it's instead a kind of restart of streams, don't add
> > > this flag.  The lack of the flag doesn't mean that the driver can't
> > > resume at all.
> > 
> > Yes, with this patch series we are able to resume from previous position.
> 
> I suppose you tested hibernation, too?

No, only suspend and freeze

> How does it assure that the in-flight data on FIFO are restored after
> the link reset and re-prepare?

SKL has DMA resume capability, so we can restore the registers, Jeeja is
preparing those patches and we should be able to send those shortly :)

> > Here is my test:
> > 
> > # aplay -Dhw:0,0 play.wav
> > Playing WAVE 'play.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
> > Stereo
> > Suspended. Trying resume. Done.
> 
> As mentioned, the resume usually works (sort of), even without
> SNDRV_PCM_INFO_RESUME bit.  It's because alsa-lib tries to re-prepare
> the stuff by itself.
> 
> Did you try only the patch 2 without this patch?

Yes Jeeja did that and in that case it does prepare and resumes

-- 
~Vinod
