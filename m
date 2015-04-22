From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 7/7] ASoC: hda - added Skylake I2S
 machine driver
Date: Wed, 22 Apr 2015 08:30:25 +0530
Message-ID: <20150422030025.GA2738@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-8-git-send-email-vinod.koul@intel.com>
 <5530D612.4000109@metafoo.de> <20150417190655.GO30624@intel.com>
 <55315B85.6060008@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 30D3026047F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 05:03:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55315B85.6060008@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Omair M Abdullah <omair.m.abdullah@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 09:14:13PM +0200, Lars-Peter Clausen wrote:
> On 04/17/2015 09:06 PM, Vinod Koul wrote:
> >On Fri, Apr 17, 2015 at 11:44:50AM +0200, Lars-Peter Clausen wrote:
> >>On 04/17/2015 11:13 AM, Vinod Koul wrote:
> >>[...]
> >>>+	/* always connected - check HP for jack detect */
> >>>+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> >>>+	snd_soc_dapm_enable_pin(dapm, "Speaker");
> >>>+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> >>>+	snd_soc_dapm_enable_pin(dapm, "DMIC2");
> >>
> >>There is no need to do this, all pins are enabled by default.
> >Ah yes, thanks for pointing. With this I should also set full_routed right?
> 
> You don't have to, the two are unrelated. But I'd still recommend
> setting fully_routed.
Yes I will set this in next patch, thanks

-- 
~Vinod
