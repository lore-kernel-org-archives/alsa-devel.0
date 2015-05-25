From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/7] ASoC: intel - add skylake PCM driver
Date: Mon, 25 May 2015 16:54:58 +0530
Message-ID: <20150525112458.GF3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <s5hsial16wu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 24447260686
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 13:23:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsial16wu.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2015 at 08:57:05AM +0200, Takashi Iwai wrote:
> At Mon, 11 May 2015 16:23:58 +0530,
> Vinod Koul wrote:
> > 
> > SKL has HDA controller based audio subsystem with DSP and support for I2S,
> > HDA, PDM links. The hda core code has been moved to sound/hda/ by Takashi
> > which current HDA drivers use and will also be used by ASoC SKL driver.
> > 
> > The SKL platform driver will load and create the soc_hdac_bus which embeds
> > the hdac_bus, same for hdac_device (hda codecs) and hdac_stream (pcms) This
> > is on top of hdac code in Takashi's topic/hda
> > 
> > This patch provides the match function for asoc type hda codecs and let's
> > them get enumerated by hdac. The second patch in this series adds the
> > controller specific soc code. Common parts are in hdac core with changes
> > introduced as part of SKL controller in soc part. Then we add the rest of
> > controller PCM driver code (still HDA) and last patch breaks the HDA streams
> > to host and link which will allow insertion of DSP in between these links.
> > 
> > The subsequent series will add IPC driver for SKL (using common IPC
> > routines), then DSP topology handlers, DSP code with I2S support and then
> > lastly when DFW is accepted then its handlers.
> > 
> > This patch series adds the hda codec match functions followed by asoc hda
> > controller routines, then SKL PCM driver and last decouples the controller
> > for splitting the links
> 
> Merging this without the codec driver would be rather confusing for
> users, since it gives a conflicting driver that doesn't work at all.
> I suppose that the merge should be pending until the complete
> implementation of ASoC HDA.
Well users wont notice till we have a machine driver which selects this
driver. That is why machine driver will come last and needs to be
merged only after controller and codec drivers are merged for end
users to notice

-- 
~Vinod
