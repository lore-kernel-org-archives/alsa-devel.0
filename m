From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst
 settings device tree options
Date: Thu, 14 Jan 2016 18:33:25 -0800
Message-ID: <20160115023325.GA29132@Asurada-Nvidia>
References: <1452788982-11583-1-git-send-email-caleb@crome.org>
 <20160114201858.GA17567@Asurada-Nvidia>
 <56984BE7.2050303@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56984BE7.2050303@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Caleb Crome <caleb@crome.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 07:31:19PM -0600, Timur Tabi wrote:
> Nicolin Chen wrote:
> >I think DT maintainers may not give a consent towards these two
> >properties as they are not to describe the hardware but to hack
> >software configurations. (And it seems you haven't CCed them.)
 
> I admit it's a grey area, but the hardware doesn't work if you use
> the wrong value, and it is a fixed value per device.  A p1022ds
> would use a different value than in in i.MX6, and once you pick a
> value, it's the same no matter which sample rate, buffer size, etc
> you choose.

Wish we could settle down a common solution for each case. If that
doesn't work for PPC, we may confine the modifications to i.MX only
by overriding those settings in the fsl_ssi_imx_probe() for safety.
