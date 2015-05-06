From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/7] ASoC: hda - add soc hda codec
	driver wrapper
Date: Wed, 6 May 2015 22:21:11 +0530
Message-ID: <20150506165111.GV3521@localhost>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-2-git-send-email-vinod.koul@intel.com>
 <20150504131226.GV15510@sirena.org.uk>
 <20150506034750.GO3521@localhost>
 <20150506125123.GT22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 44AA5260682
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:50:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150506125123.GT22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 06, 2015 at 01:51:23PM +0100, Mark Brown wrote:
> On Wed, May 06, 2015 at 09:17:50AM +0530, Vinod Koul wrote:
> > On Mon, May 04, 2015 at 02:12:26PM +0100, Mark Brown wrote:
> 
> > > If this is for CODECs why is it in a new directory?
> 
> > yes it is for HDA codecs which are enumerated over HDA links, but this is
> > the HDA bus code which is ASoC specfic. All generic HDA code which uses the
> > hda lib (new sound/hda) is kept in sound/soc/hda
> > All intel driver updates will go to sound/soc/intel/skylake
> > The codecs drivers will as usual show up in sound/soc/codecs/
> 
> I'm still not 100% clear as to what a "HDA CODEC wrapper" is intended to
> be.  I think this series probably needs an introduction which describes
> what the overall picture we're aiming for is.
okay let me try that here as well as next version which i will post
tomorrow.

So SKL has HDA controller based audio subsystem with DSP and gets better
with support for I2S, HDA, PDM links.

So we worked with Takashi on HDA parts and now we have core code of HDA moved
into sound/hda which current HDA drivers use and will also be used by ASoC
SKL driver.

The SKL platform driver will load and create the soc_hdac_bus which would
embed the hdac_bus, same for hdac_device (hda codecs) and hdac_stream (pcms)
This is on top of hdac code in Takashi's topic/hda

This patch provides the match function for asoc type hda codecs and lets
them get enumerated by hdac. The second patch in this series adds the
controller specific soc code. Common parts are in hdac core with changes
introduced as part of SKL controller in soc part. Then we add the rest of
controller PCM driver code (still HDA) and last patch breaks the HDA streams
to host and link which will allow insertion of DSP in between these links.

The subsequent series will add IPC driver for SKL (using common IPC
routines), then DSP topology handlers, DSP code with I2S support and then
lastly when DFW is accepted then its handlers.

Let me know if you have more questions around this, would be happy to answer
them :)

Thanks
-- 
~Vinod
