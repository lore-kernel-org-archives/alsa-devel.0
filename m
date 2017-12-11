From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v5 03/15] soundwire: Add Master registration
Date: Mon, 11 Dec 2017 22:14:08 +0530
Message-ID: <20171211164408.GS18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-4-git-send-email-vinod.koul@intel.com>
 <s5hd13ll0cd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hd13ll0cd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 05:02:10PM +0100, Takashi Iwai wrote:
> On Wed, 06 Dec 2017 16:46:59 +0100,
> Vinod Koul wrote:
> > 
> > +	/* Set group device numbers and master device number */
> > +	set_bit(SDW_GROUP12_DEV_NUM | SDW_GROUP13_DEV_NUM, bus->assigned);
> 
> Is this really correct?

Nope, this is supposed to bit number and can't be ORed, will fix thanks

-- 
~Vinod
