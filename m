From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: export
 dapm_kcontrol_set/get_value functions
Date: Thu, 29 May 2014 12:55:07 +0200
Message-ID: <5387120B.6090100@metafoo.de>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-248.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 321BA2610A5
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 12:55:11 +0200 (CEST)
In-Reply-To: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
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
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/29/2014 12:03 PM, Vinod Koul wrote:
> The DSPs like Intel ones use the DPCM to represent the DSP toplogy. So when DAPM
> triggers the widget, the DSP needs to know the kcontrol values and pass on to DSP
> firmware, so export these for driver use
>

As I said I feel a bit uneasy about exporting these and I'd rather much 
prefer to see this patch in context (i.e. in the same series as its user).

- Lars
