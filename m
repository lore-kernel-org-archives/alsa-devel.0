From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] conf/ucm: broxton: add broxton-rt298 conf
	files
Date: Fri, 13 Jan 2017 10:22:44 +0530
Message-ID: <20170113045244.GM3573@localhost>
References: <1484212828-10041-1-git-send-email-vinod.koul@intel.com>
 <1484217487.2604.68.camel@loki> <s5hr348wnh4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F39F266C2A
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 05:52:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr348wnh4.wl-tiwai@suse.de>
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
Cc: Nishit Sharma <nishitx.sharma@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, alsa-devel@alsa-project.org, patches.audio@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 12, 2017 at 12:01:59PM +0100, Takashi Iwai wrote:
> On Thu, 12 Jan 2017 11:38:07 +0100,
> Liam Girdwood wrote:
> > 
> > On Thu, 2017-01-12 at 14:50 +0530, Vinod Koul wrote:
> > > This adds the UCM conf files for broxton enabling with rt298 codec on
> > > I2S audio, HDMI and DMIC ports.
> > > 
> > > Signed-off-by: Nishit Sharma <nishitx.sharma@intel.com>
> > > Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
> > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > Can you redo using the UCM include support. That way we can separate the
> > codec stuff out from the DSP stuff and make it easier to use new codecs.
> 
> Oh, I already applied and pushed now before reading your comment.
> Vinod, please give the incremental patch.

Sure, that waas on our list anyway for SKL UCM, will get that done for both
SKL and APL..

-- 
~Vinod
