From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Fri, 20 Oct 2017 12:39:34 +0200
Message-ID: <20171020103934.GA3210@kroah.com>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C937266A51
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 12:39:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 08:33:17AM +0530, Vinod Koul wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
> 
> SoundWire is a new Linux bus which implements a new MIPI bus protocol
> 'SoundWire'. The summary of SoundWire bus and registration APIs is
> documented in the 'summary' file.
> 
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  Documentation/soundwire/summary.txt | 192 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>  create mode 100644 Documentation/soundwire/summary.txt

Any specific reason this is not in .rst format and tied to the rest of
the kernel Documentation so it gets built automatically?

thanks,

greg k-h
