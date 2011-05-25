From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/6] ASoC: davinci-pcm: some fixes and
	convert to BATCH
Date: Wed, 25 May 2011 10:54:45 +0100
Message-ID: <4DDCD1E5.8010506@ti.com>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AEFDC103824
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 11:54:48 +0200 (CEST)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On 24/05/11 19:50, Ben Gardiner wrote:
> This patchset is a collection of changes for the davinci-pcm driver that were
> accumulated during previous forays into the davinci-mcasp and davinci-pcm
> drivers [1].
> 
> The first three patches are minor changes that cleanup the ping-pong DMA params
> setup, expand the davinci-pcm reported format and also its maximum channels.
> 
> The fourth patch in the series corrects an audible glitch that can be heard on
> da850evm's McASP when ping-pong buffers are enabled. The glitch occurs only
> on the second and susequent playbacks, not the first. Reversing the order in
> which the dma channels are started and moving the start to the trigger function
> from the prepare function fixes the glitch.
> 
> The fifth and sixth patches in the series convert the davinci-pcm driver to
> BATCH mode. 
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>

One minor thing for patch 6 that can be added incrementally.
