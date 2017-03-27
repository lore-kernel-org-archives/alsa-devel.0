From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: Don't print FW version
	repeatedly
Date: Mon, 27 Mar 2017 15:55:25 +0530
Message-ID: <20170327102525.GJ9308@localhost>
References: <20170327083958.18020-1-tiwai@suse.de>
 <20170327100658.GI9308@localhost>
 <20170327101354.fgvu2s6ewdccha67@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5882926583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:24:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170327101354.fgvu2s6ewdccha67@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 27, 2017 at 11:13:54AM +0100, Mark Brown wrote:
> On Mon, Mar 27, 2017 at 03:36:58PM +0530, Vinod Koul wrote:
> > On Mon, Mar 27, 2017 at 10:39:58AM +0200, Takashi Iwai wrote:
> 
> > > -	dev_info(sst_drv_ctx->dev, "FW Version %02x.%02x.%02x.%02x\n",
> > > +	if (memcmp(&sst_drv_ctx->fw_version, &init->fw_version,
> > > +		   sizeof(init->fw_version)))
> 
> > wont dev_info_once be better here? We are really not expecting a new version
> > after suspend :)
> 
> You are if someone upgrades their userspace.

Ah yes thats a good point indeed, so:

Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks
-- 
~Vinod
