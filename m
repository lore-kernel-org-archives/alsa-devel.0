From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/3] conf: topology: Add Skylake i2s conf
Date: Thu, 21 Apr 2016 16:24:04 +0530
Message-ID: <20160421105403.GO2274@localhost>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
 <1461220058-1378-2-git-send-email-vinod.koul@intel.com>
 <s5hwpnrxw7y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EAAB266855
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 12:49:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwpnrxw7y.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2016 at 09:22:09AM +0200, Takashi Iwai wrote:
> > +++ b/src/conf/topology/sklrt286/Makefile.am
> > @@ -0,0 +1,11 @@
> > +alsaconfigdir = @ALSA_CONFIG_DIR@
> > +SUBDIRS = data
> > +sklrt286dir = $(alsaconfigdir)/topology/sklrt286
> > +sklrt286_DATA = skl_i2s.conf
> > +EXTRA_DIST = sklrt286_DATA
> 
> Isn't it $(sklrt286_DATA)?

Yes, will fix

> > +install-data-hook:
> > +	cp -p media0_in-cpr-0.bin media0_in-mi.bin media0_out-mo.bin media0_out-cpr-6.bin codec0_out-mo.bin codec0_out-cpr-4.bin codec1_out-mo.bin codec1_out-cpr-5.bin codec0_in-cpr-1.bin codec0_in-mi.bin dmic01_hifi_in-cpr-3.bin dmic01_hifi_in-mi.bin hdmi1_pt_out-cpr-7.bin hdmi1_pt_out-cpr-8.bin hdmi2_pt_out-cpr-9.bin hdmi2_pt_out-cpr-10.bin hdmi3_pt_out-cpr-11.bin hdmi3_pt_out-cpr-12.bin $(sklrt286dir)
> 
> I guess these bin files aren't present or generated in this patch?
> This would break bisection.

Okay, will move this to second one

-- 
~Vinod
