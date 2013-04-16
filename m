From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 00/15] ASoC: fsl-ssi: ac97-slave support
Date: Tue, 16 Apr 2013 10:06:26 +0200
Message-ID: <516D0682.5010309@metafoo.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <516A9D5B.2070707@metafoo.de> <516C9A87.4090307@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-206.synserver.de (smtp-out-207.synserver.de
 [212.40.185.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D3822652BF
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 10:07:16 +0200 (CEST)
In-Reply-To: <516C9A87.4090307@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 04/16/2013 02:25 AM, Timur Tabi wrote:
> Lars-Peter Clausen wrote:
>>> >@Lars:
>>> >There are 4 new patches at the beginning of the series that fix some
>>> problems
>>> >of your cleanups. I think they were in the changes you posted. If not,
>>> could you
>>> >please add them to your branch?
>> Hi,
>>
>> I had already fixed them localy. I'm in the process of polishing the last
>> bits
>> and pieces of my generic dmaengine PCM driver series right now and will
>> submit
>> it later today.
> 
> So which repository should I apply these patches to?  I want to make sure
> they don't break PowerPC.
> 

You can use
https://github.com/lclausen-adi/linux-2.6/tree/asoc-dmaengine-cleanups, but
make sure to skip the first 4 patches from this series.

- Lars
