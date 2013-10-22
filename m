From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: ep93xx: Open code dma channel
 request
Date: Tue, 22 Oct 2013 14:05:37 +0200
Message-ID: <52666A11.6000401@metafoo.de>
References: <1382188384-18063-1-git-send-email-broonie@kernel.org>
 <1382188384-18063-2-git-send-email-broonie@kernel.org>
 <5262BF2D.1080104@metafoo.de> <20131019200032.GD2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-203.synserver.de (smtp-out-204.synserver.de
 [212.40.185.204])
 by alsa0.perex.cz (Postfix) with ESMTP id B79FB261281
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 14:07:45 +0200 (CEST)
In-Reply-To: <20131019200032.GD2443@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 10:00 PM, Mark Brown wrote:
> On Sat, Oct 19, 2013 at 07:19:41PM +0200, Lars-Peter Clausen wrote:
>> On 10/19/2013 03:13 PM, Mark Brown wrote:
>> [...]
>>>  static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
>>>  	.pcm_hardware = &ep93xx_pcm_hardware,
>>>  	.compat_filter_fn = ep93xx_pcm_dma_filter,
> 
>> The compat_filter_fn attribute should probably removed
> 
> Yeah, I was in two minds about that.  Obviously the ideal thing is to
> change the drivers so they can use the filter function again; from that
> point of view it's kind of like what's going on with Tegra in intention
> - it is notionaly using the filter function, it's just that the DAIs are
> putting the data in the wrong place at the minute.

Ok.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
