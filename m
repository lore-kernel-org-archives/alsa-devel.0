From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] ALSA: hda: add module flag
	snd_adsp_enable
Date: Mon, 22 Jun 2015 16:28:35 +0530
Message-ID: <20150622105835.GD19530@localhost>
References: <1434609505-776-1-git-send-email-vinod.koul@intel.com>
 <s5hioak9bf1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E1EC4261ADC
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 12:57:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hioak9bf1.wl-tiwai@suse.de>
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

On Fri, Jun 19, 2015 at 01:37:22PM +0200, Takashi Iwai wrote:
> At Thu, 18 Jun 2015 12:08:23 +0530,
> Vinod Koul wrote:
> > 
> > This is second attempt for creating a module option for hda core to
> > select either legacy HDA driver or upcoming ASoC driver.  This series
> > still relies on module flag (with feedback from previous series baked
> > in). The eventual plan is to rely on HW advertised capabilities and
> > BIOS configuration to load either driver, but since ASoC driver has
> > still some time to get fully merged and matured on various system, we
> > will rely on module flag till the who ASoC HDA systems is completed
> > and available is all distros
> 
> Well, somehow I prefer postponing this.  The method would work but is
> indeed hackish, so let's put this together with other pieces as a last
> resort unless any better solution is found.  For the driver
> development itself, this isn't really needed; you can put blacklist at
> any time.
Okay blacklist will work too...

-- 
~Vinod
