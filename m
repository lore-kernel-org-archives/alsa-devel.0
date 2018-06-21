From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Subject: Re: [RESEND][PATCH] ASoC: hdac_hdmi: Program
 pin-port-mux during jack report event
Date: Thu, 21 Jun 2018 16:15:34 +0530
Message-ID: <20180621104533.GA10220@intel.com>
References: <1529492902-6600-1-git-send-email-sriramx.periyasamy@intel.com>
 <s5ho9g5mx2e.wl-tiwai@suse.de> <20180621075419.GA10037@intel.com>
 <s5hfu1glf0u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 648AD2676C3
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:57:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfu1glf0u.wl-tiwai@suse.de>
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
Cc: ALSA ML <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 21, 2018 at 10:28:33AM +0200, Takashi Iwai wrote:
> On Thu, 21 Jun 2018 09:54:20 +0200,
> Sriram Periyasamy wrote:
> > 
> > On Wed, Jun 20, 2018 at 03:01:13PM +0200, Takashi Iwai wrote:
> > > On Wed, 20 Jun 2018 13:08:21 +0200,
> > > Sriram Periyasamy wrote:
> > > > 
> > > > During d3/d0 cycle, the connection selection index of all pins points
> > > > to the default value. This needs to be restored to ensure audio is
> > > > restored after d3/d0 cycle.
> > > > 
> > > > So store the connection selection index and program it during jack
> > > > report event which gets invoked in cases like d3/d0 cycle, hot plug
> > > > detection when multiple displays are connected.
> > > 
> > > Hm, I thought *_CONNECT_SEL being cached and restored at resume
> > > already by regmap?
> > > 
> > 
> > Yes, legacy HDA HDMI driver has this method whereas ASoC based HDAC HDMI
> > driver doesn't use regmap. Hence we needed this solution.
> 
> If so, why not just use the standard snd_hdac_codec_write()?
> 

Because snd_hdac_codec_write doesn't power up the device to send the verb
across the link when the device is runtime suspended.

Thanks,
Sriram.
