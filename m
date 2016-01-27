From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add FE DAIs
 dynamically
Date: Wed, 27 Jan 2016 10:56:39 +0100
Message-ID: <56A89457.4040307@metafoo.de>
References: <cover.1452844210.git.mengdong.lin@linux.intel.com>
 <b7e208201542e5a27d052eb9e9f780056542db03.1452844210.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-124.synserver.de (smtp-out-208.synserver.de
 [212.40.185.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 8660B2606C1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 10:56:43 +0100 (CET)
In-Reply-To: <b7e208201542e5a27d052eb9e9f780056542db03.1452844210.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, subhransu.s.prusty@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org

On 01/15/2016 09:13 AM, mengdong.lin@linux.intel.com wrote:
[...]
> +		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
> +							caps->rate_max);

How about just setting stream->rate_min and stream->rate_max?

- Lars
