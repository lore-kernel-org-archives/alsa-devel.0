From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 1/6] Documentation: soundwire: Add
 documentation for Multi link
Date: Wed, 6 Jun 2018 11:51:39 +0530
Message-ID: <20180606062139.GB16230@vkoul-mobl>
References: <1528196497-29554-1-git-send-email-shreyas.nc@intel.com>
 <1528196497-29554-2-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD24267172
 for <alsa-devel@alsa-project.org>; Wed,  6 Jun 2018 08:28:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1528196497-29554-2-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On 05-06-18, 16:31, Shreyas NC wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
> 
> Add example and documentation to describe Multi Link streams
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>  Documentation/driver-api/soundwire/stream.rst | 30 ++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
> index 29121aa..af9529b 100644
> --- a/Documentation/driver-api/soundwire/stream.rst
> +++ b/Documentation/driver-api/soundwire/stream.rst
> @@ -76,7 +76,35 @@ Slaves are using single port. ::
>  	                                                   +---------------+
>  
>  
> -Example 4: Stereo Stream with L and R channel is rendered by two different
> +Example 4: Stereo Stream with L and R channel is rendered by 2 Masters, each

We already have an example 4, shouldn't this be 5th one, can you check?
I would prefer adding new example at the end and not in middle..

> +rendering one channel, and is received by two different Slaves, each
> +receiving one channel. Both Masters and both Slaves are using single port. ::
> +
> +	+---------------+                    Clock Signal  +---------------+
> +	|    Master     +----------------------------------+     Slave     |
> +	|   Interface   |                                  |   Interface   |
> +	|       1       |                                  |       1       |
> +	|               |                     Data Signal  |               |
> +	|       L       +----------------------------------+       L       |
> +	|     (Data)    |     Data Direction               |     (Data)    |
> +	+---------------+  +----------------------->       +---------------+
> +
> +	+---------------+                    Clock Signal  +---------------+
> +	|    Master     +----------------------------------+     Slave     |
> +	|   Interface   |                                  |   Interface   |
> +	|       2       |                                  |       2       |
> +	|               |                     Data Signal  |               |
> +	|       R       +----------------------------------+       R       |
> +	|     (Data)    |     Data Direction               |     (Data)    |
> +	+---------------+  +----------------------->       +---------------+
> +
> +Note: In multi-link cases like above, to lock, one would acquire a global
> +lock and then go on locking bus instances. But, in this case the caller
> +framework(ASoC DPCM) guarantees that stream operations on a card are
> +always serialized. So, there is no race condition and hence no need for
> +global lock.
> +
> +Example 5: Stereo Stream with L and R channel is rendered by two different
>  Ports of the Master and is received by only single Port of the Slave
>  interface. ::
>  
> -- 
> 2.7.4

-- 
~Vinod
