From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 1/5] ALSA: hda - move
	bus_parse_capabilities to core
Date: Thu, 4 Aug 2016 07:26:56 +0530
Message-ID: <20160804015656.GY9681@localhost>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
 <1470240374-20018-2-git-send-email-vinod.koul@intel.com>
 <s5hk2fx96mu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 24FD72651F2
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 03:49:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk2fx96mu.wl-tiwai@suse.de>
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

On Wed, Aug 03, 2016 at 06:09:13PM +0200, Takashi Iwai wrote:

> > +		dev_dbg(bus->dev, "Capability version: 0x%x\n",
> > +				((cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF));
> 
> Too much indentation.  Also the parentheses are superfluous (unlike
> below).

Okay, I didn't modify this piece and copied. Will update this.

> 
> > +
> > +		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
> > +				(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
> 
> Too much indentation.

ok

> > +		/* read the offset of next capabiity */
> 
> A typo.

ok

-- 
~Vinod
