From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 00/15] soundwire: Add a new SoundWire
	subsystem
Date: Wed, 13 Dec 2017 10:18:22 +0100
Message-ID: <20171213091822.GD6269@kroah.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2ED266AE4
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 10:18:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 06, 2017 at 09:16:56PM +0530, Vinod Koul wrote:
> This patch series adds a new SoundWire subsystem which implements a
> new MIPI bus protocol 'SoundWire'.
> 
> The SoundWire protocol is a robust, scalable, low complexity, low
> power, low latency, two-pin (clock and data) multi-drop bus that
> allows for the transfer of multiple audio streams and embedded
> control/commands.  SoundWire provides synchronization capabilities
> and supports both PCM and PDM, multichannel data, isochronous and
> asynchronous modes.
> 
> This series adds SoundWire Bus, IO transfers, DisCo (Discovery and
> Configuration) sysfs interface, regmap and Documentation summary
> 
> This patch series is also available on
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git topic/patch_v5
> 
> v4: https://lkml.org/lkml/2017/12/1/205
> v3: https://lkml.org/lkml/2017/11/30/160
> v2: https://lkml.org/lkml/2017/11/10/216
> v1: https://lkml.org/lkml/2017/10/18/1030
> RFC: https://lkml.org/lkml/2016/10/21/395

I don't think patch 5 is right, how you are using kobjects.

Also, you have to have some documentation on your userspace API here for
it to be reviewable.  To hide sysfs trees and files in code comments is
not good.

thanks,

greg k-h
