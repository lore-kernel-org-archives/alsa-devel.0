From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm - Add DAPM stream completion
	event.
Date: Mon, 25 Jul 2011 22:08:08 +0100
Message-ID: <20110725210807.GA6086@opensource.wolfsonmicro.com>
References: <1311588915-3402-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32B6324142
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 23:08:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311588915-3402-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2011 at 11:15:15AM +0100, Liam Girdwood wrote:
> In preparation for Dynamic PCM (AKA DSP) support.
> 
> This adds a callback function to be called at the completion of a DAPM stream
> event.
> 
> This can be used by DSP components to perform calculations based on DAPM graphs
> after completion of stream events.

Applied, thanks.
