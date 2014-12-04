From: Zidan Wang <B50113@freescale.com>
Subject: RE: [alsa-devel][PATCH v2] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Thu, 4 Dec 2014 12:34:20 +0000
Message-ID: <BY1PR0301MB1253AD2792540463CD7D70F68D780@BY1PR0301MB1253.namprd03.prod.outlook.com>
References: <1417681425-4360-1-git-send-email-b50113@freescale.com>
 <20141204112512.GS7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141204112512.GS7712@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your reply. 
You are right, the machine driver should disable the PLL.


Best Regards,
Zidan

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Thursday, December 04, 2014 7:25 PM
To: Wang Zidan-B50113
Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.de; lars@metafoo.de; ckeepax@opensource.wolfsonmicro.com; Xiubo Li-B47053; patches@opensource.wolfsonmicro.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH v2] ASoC: wm8960: Let wm8960 codec driver manage its own MCLK

On Thu, Dec 04, 2014 at 04:23:45PM +0800, Zidan Wang wrote:

> If we use PLL to generate sysclk, wm8960_set_dai_pll() will enable 
> PLL. But PLL doesn't power down after using codec. So power down PLL in suspend().

That would be a bug in the machine driver, the machine driver should be disabling the PLL when it suspends since the startup and shutdown of the PLL need to be coordinated with the input clocks.  Besides, if we were doing this in the CODEC driver then as I said last time the PLL needs to be restored on resume since the machine driver should be able to expect that settings it has made are preserved (eg, if it sets things up on init).
