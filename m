From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 08/15] soundwire: Add Slave status
 handling helpers
Date: Mon, 4 Dec 2017 08:43:20 +0530
Message-ID: <20171204031319.GW32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-9-git-send-email-vinod.koul@intel.com>
 <4b464ced-5801-724e-1ec0-bae5b468b4dd@linux.intel.com>
 <20171203170818.GO32417@localhost>
 <b5f75b94-f0c6-d113-67dc-c159f0ca6a79@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B7F2F26710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 04:09:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b5f75b94-f0c6-d113-67dc-c159f0ca6a79@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 03, 2017 at 09:07:29PM -0600, Pierre-Louis Bossart wrote:
> On 12/3/17 11:08 AM, Vinod Koul wrote:
> >On Fri, Dec 01, 2017 at 05:36:47PM -0600, Pierre-Louis Bossart wrote:
> >
> >>>+/* called with bus_lock held */
> >>>+static int sdw_get_device_num(struct sdw_slave *slave)
> >>>+{
> >>>+	int bit;
> >>>+
> >>>+	bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> >>>+	if (bit == SDW_MAX_DEVICES) {
> >>>+		bit = -ENODEV;
> >>>+		goto err;
> >>
> >>My brain is starting to fry but is this correct? Bit11 seems like a valid
> >>value. Should it be bit > 15 (assuming bit 12,13,14 are set to avoid using
> >>groups and master)?
> >
> >this is correct. You are confusing SDW concept and API return types!
> >That should be hint for you to start weekend if you didn't do so :D
> >
> >This API returns max value it was provided (last arg) if it doesn't
> >find free bit. That's an indication to caller that we ran out of devices
> >hence ENODEV error!
> 
> Can you just make sure bit11 is included?

yes it is, refer to the masks we set for bit, only 0 and 15 and now 12,13
and 14 will be masked out. So we can get from 1 to 11 both inclusive.

-- 
~Vinod
