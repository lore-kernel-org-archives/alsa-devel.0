From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: check suspend state in
	dapm_dai_check_power()
Date: Mon, 03 Jun 2013 21:16:36 +0200
Message-ID: <51ACEB94.9020205@metafoo.de>
References: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
 <20130603185120.GS31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-070.synserver.de (smtp-out-074.synserver.de
 [212.40.185.74])
 by alsa0.perex.cz (Postfix) with ESMTP id D2397264FB0
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 21:21:54 +0200 (CEST)
In-Reply-To: <20130603185120.GS31367@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 06/03/2013 08:51 PM, Mark Brown wrote:
> On Mon, Jun 03, 2013 at 11:36:40AM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Currently, when the system enters suspend with audio playing, since the
>> DAI widgets are active, the associated CODEC is considered active, and
>> hence is not transition into a low-power bias state as the system
>> suspends. This likely causes audio failure after resume, since the CODEC
>> power has quite possibly been removed during suspend, and the bias level
>> transitions in the CODEC driver are needed to recover from this. At the
>> very least, this issue likely causes warnings in the kernel log due to
>> the CODEC being left on over the suspend transition.
>>
>> To solve this, modify dapm_dai_check_power() not to consider DAI widgets
>> active if the system is entering suspend.
> 
> I would expect us to be dealing with this as part of quiescing the DMA
> operations on the links - it's not just the CODEC that needs handling
> here.  This feels like it ought to be more joined up somewhere along the
> line.

I think it is just an oversight that this is not working properly right now.
In snd_soc_suspend() where we also stop the DMA streams etc the DAI link
widgets are put into suspend, by calling snd_soc_dapm_stream_event(...,
SND_SOC_DAPM_STREAM_SUSPEND). But dapm_dai_check_power() doesn't consider
this and hence stays active and also keeps the whole DAPM context (this is
not CODEC specific) active.

- Lars
