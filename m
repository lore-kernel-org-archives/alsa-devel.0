From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: simple-audio-card vs. platform question
Date: Tue, 27 Jan 2015 13:29:03 +0100
Message-ID: <54C7848F.6070903@metafoo.de>
References: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id AA295260715
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 13:29:04 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1501271301400.11532@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/27/2015 01:01 PM, Ricard Wanderlof wrote:
>
> I'm trying to set up a simple device tree framework so I can do some
> development on an I2S driver. I'm trying to use simple-audio-card, but I
> keep running into the problem that once soc_bind_dai_link() gets called,
> dai_link->platform is set to NULL (because it is not initialized by
> simple-card.c when there is a DT node), while dai_link->platform_of_node
> has been set to dai_link->cpu_of_node in asoc_simple_card_parse_of().
>
[...]
>
> I can't figure out either how to set up a platform (=DMA) driver in this
> environment. Perhaps the case of having a CPU DAI, DMA driver and codec
> DAI is not supported by simple-audio-card?
[...]

Usually in such a setup the CPU DAI driver also register the platform 
component. Which then as the same of_node as the CPU DAI and so the matching 
works. There are plenty of examples e.g. check the drivers using 
devm_snd_dmaengine_pcm_register().

- Lars
