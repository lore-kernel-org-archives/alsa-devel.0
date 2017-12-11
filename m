From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 04/15] soundwire: Add MIPI DisCo
	property helpers
Date: Mon, 11 Dec 2017 22:30:22 +0530
Message-ID: <20171211170022.GT18649@localhost>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-5-git-send-email-vinod.koul@intel.com>
 <s5hbmj5kzyu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id DF943266EDD
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 17:56:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbmj5kzyu.wl-tiwai@suse.de>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, patches.audio@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 11, 2017 at 05:10:17PM +0100, Takashi Iwai wrote:
> On Wed, 06 Dec 2017 16:47:00 +0100,
> Vinod Koul wrote:
> > 
> > +static int sdw_slave_read_dpn(struct sdw_slave *slave,
> > +		struct sdw_dpn_prop *dpn, int count, int ports, char *type)
> > +{
> ....
> > +		nval = fwnode_property_read_u32_array(node,
> > +				"mipi-sdw-port-wordlength-configs", NULL, 0);
> > +		if (nval > 0)
> > +			dpn[i].num_words = nval;
> > +
> > +		if (dpn[i].num_words) {
> > +			dpn[i].words = devm_kcalloc(&slave->dev, nval,
> > +				sizeof(*dpn[i].words), GFP_KERNEL);
> 
> Inconsistent checks here: nval or dpn[i].num_words.

Ah yes, we should not do allocation for less that zero case and use it
properly, will fix this and others

> 
> > +		/* TODO: Read audio mode */
> > +
> > +		i++;
> > +	}
> 
> Don't we use count argument for a sanity check?

Not really as that iterator runs on each bit:

for_each_set_bit(bit, &addr, 32) {

so it will not go on endlessly and can max out when all the bits being set
and stop.

-- 
~Vinod
