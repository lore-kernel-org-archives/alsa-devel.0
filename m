From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Log a warning when machines
	use soc-audio
Date: Fri, 02 Mar 2012 15:55:07 +0000
Message-ID: <1330703707.29333.0.camel@odin>
References: <1330693693-23097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D30024517
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 16:55:22 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id g1so1276451wer.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 07:55:09 -0800 (PST)
In-Reply-To: <1330693693-23097-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2012-03-02 at 13:08 +0000, Mark Brown wrote:
> snd_soc_register_card() has been available and strongly preferred since
> 2.6.38 but we're still seeing new drivers using it and the conversion rate
> for older machines has been low. Help address both issues by logging a
> warning when the soc-audio device probes.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
