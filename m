From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 07/10] ASoC: upd9976: add jack detection
	function
Date: Fri, 6 May 2011 13:53:11 +0100
Message-ID: <20110506125308.GI23729@opensource.wolfsonmicro.com>
References: <20110506053852.26312.79083.stgit@localhost>
	<20110506054634.26312.80750.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEE7A24395
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 14:53:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110506054634.26312.80750.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 01:46:34PM +0800, Lu Guanqun wrote:

> +	if (interrupt_status & 0x1 && value == 0x1)
> +		status |= SND_JACK_HEADSET;
> +
> +	if (interrupt_status & 0x2 && value == 0x2)
> +		status |= SND_JACK_HEADPHONE;
> +
> +	if (interrupt_status & 0x4)
> +		status |= SND_JACK_HEADSET | SND_JACK_BTN_0;
> +
> +	if (interrupt_status & 0x8)
> +		status |= SND_JACK_HEADSET | SND_JACK_BTN_1;

It's very strange that you do a mix of checks with and without the == -
it doesn't matter either way but it'd be clearer to be consistent.

> +	if (upd9976->irq < 0 || !upd9976->irq_mem)
> +		return 0;

It'd seem better to have this condition the other way around so if you
need to add more conditional stuff things will be clearer.
