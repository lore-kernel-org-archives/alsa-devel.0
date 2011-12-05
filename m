From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Provide a more complete DMA driver
	stub
Date: Mon, 05 Dec 2011 22:02:50 +0000
Message-ID: <1323122570.8134.1.camel@odin>
References: <1323118585-18216-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A297C2436E
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 23:02:56 +0100 (CET)
Received: by mail-ee0-f45.google.com with SMTP id a50so3177546eeb.4
	for <alsa-devel@alsa-project.org>; Mon, 05 Dec 2011 14:02:53 -0800 (PST)
In-Reply-To: <1323118585-18216-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-12-05 at 20:56 +0000, Mark Brown wrote:
> Allow userspace applications to do more parameter setting by providing a
> more complete stub DMA driver specifying a wildcard set of formats and
> channels and essentially random values for the DMA parameters. This is
> required for useful runtime operation of the dummy DMA driver until we
> are able to figure out how to power up links and do hw_params() from DAPM.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Is this also intended to be used for hostless DAI links e.g.

MODEM <-> MCBSP <-> DSP

Regards

Liam 
