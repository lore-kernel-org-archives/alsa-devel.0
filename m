From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Audio Miniconference 2013 schedule - Edinburgh
 21st October
Date: Mon, 07 Oct 2013 10:22:42 -0700
Message-ID: <5252EDE2.9070902@codeaurora.org>
References: <20131003181754.GE27287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id A4253265176
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 19:22:44 +0200 (CEST)
In-Reply-To: <20131003181754.GE27287@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On 10/3/2013 11:17 AM, Mark Brown wrote:
> The first question is if there is anything important that is missing
> from the above list - please speak up soon if there is!

Lately, there has been a lot of emphasis on reducing cold start latency
which audio hardware path setup takes up good chunk of time. I found
DAPM takes up quite a bit of time finding path to enable. In addition,
DPCM could be enhanced to save on cold start latency by enabling
front-end & back-end in parallel if underlying hardware can support it.

I would like to see if we can have some discussion on optimization.

Thanks
Patrick

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
