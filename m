From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Make platform probe more like
	codec probe.
Date: Sat, 2 Jul 2011 11:50:35 -0700
Message-ID: <20110702185032.GA10032@opensource.wolfsonmicro.com>
References: <1309535648-4203-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EC80246F1
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jul 2011 20:50:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309535648-4203-1-git-send-email-lrg@ti.com>
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

On Fri, Jul 01, 2011 at 04:54:08PM +0100, Liam Girdwood wrote:
> In preparation for ASoC dynamic PCM support (AKA ASoC DSP)
> 
> Platform will also support DAPM so separate out the probe function
> to simplify the code (just like the codec probe).

Applied, thanks.
