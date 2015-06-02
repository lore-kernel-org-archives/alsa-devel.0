From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 18:09:43 +0530
Message-ID: <20150602123943.GP3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <s5h4mmv9r7m.wl-tiwai@suse.de>
 <20150602104516.GH14071@sirena.org.uk>
 <s5htwuqe60j.wl-tiwai@suse.de>
 <20150602110732.GO14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A80265057
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 14:38:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150602110732.GO14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 12:07:32PM +0100, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 12:53:00PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > Ugh, and the functions are macros so can't be used directly.  I'd still
> > > expect to see these ops be defined in some central place and reused.
> 
> > Maybe we can lift up some time later, but it's nothing more than an
> > optimization, so in a low priority for now.
> 
> It's not like it's hard to do and given that my concerns around this
> series mostly center around code reuse and abstraction I'd rather not
> have big warning signs type issues sitting there obscuring other things.
well these are read/write to registers, for SKL hidden behind writel, but
in code do help in providing functionality of reading/writing bytes/words

This is fairly *common* in drivers to use wrappers for hw accesses and yes
for overall HDA we can perhaps optimize these as Takashi pointed out but
hardly a worrying aspect/sign

Thanks
-- 
~Vinod
