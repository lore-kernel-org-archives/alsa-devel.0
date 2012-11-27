From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
Date: Mon, 26 Nov 2012 21:55:33 -0800
Message-ID: <87y5hn1tey.fsf@dell.be.48ers.dk>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
	<1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
	<20121126114511.GE9411@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121126114511.GE9411@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Mon, 26 Nov 2012 11:45:11 +0000")
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, perex@perex.cz, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

>>>>> "Mark" == Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

Hi,

 Mark> On Thu, Nov 22, 2012 at 09:34:58AM +0530, Hebbar, Gururaja wrote:
 >> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 >> +	if (IS_ERR(pinctrl))
 >> +		dev_warn(&pdev->dev,
 >> +			"pins are not configured from the driver\n");

 Mark> Since the driver is happy to continue without the pins why is it
 Mark> bothering requesting them in the first place?  In other words, this
 Mark> should be a hard error.

Sorry, I disagree. As was discussed recently, there's several reasons
why the pinctrl call might fail, and not all are fatal (E.G. pinmux
already setup by bootloader):

http://article.gmane.org/gmane.linux.kernel/1399756

-- 
Bye, Peter Korsgaard
