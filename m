From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: Don't print FW version
	repeatedly
Date: Mon, 27 Mar 2017 16:07:12 +0530
Message-ID: <20170327103712.GO9308@localhost>
References: <20170327083958.18020-1-tiwai@suse.de>
 <20170327100658.GI9308@localhost>
 <20170327101354.fgvu2s6ewdccha67@sirena.org.uk>
 <s5hpoh3nhkb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id EEDB926583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:35:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpoh3nhkb.wl-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 27, 2017 at 12:24:20PM +0200, Takashi Iwai wrote:
> On Mon, 27 Mar 2017 12:13:54 +0200,
> Mark Brown wrote:
> > 
> > On Mon, Mar 27, 2017 at 03:36:58PM +0530, Vinod Koul wrote:
> > > On Mon, Mar 27, 2017 at 10:39:58AM +0200, Takashi Iwai wrote:
> > 
> > > > -	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
> > > > +	if (memcmp(&sst_drv_ctx->fw_version, &init->fw_version,
> > > > +		   sizeof(init->fw_version)))
> > 
> > > wont dev_info_once be better here? We are really not expecting a new version
> > > after suspend :)
> > 
> > You are if someone upgrades their userspace.
> 
> Right.  If we want to keep the old one consistently, you should cache
> the firmware instead of doing request_firmware at each time.

Ah great thanks for reminding, we actually do that, so we don't load from
userspace all the time. That was done to get good latency and avoid 50ms ish
time it used to load the firmware.

see sst_cache_and_parse_fw() so dev_info_once() would suffice here

-- 
~Vinod
