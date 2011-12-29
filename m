From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a
 module
Date: Thu, 29 Dec 2011 18:37:12 +0000
Message-ID: <20111229183712.GB32392@sirena.org.uk>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
 <20111210082741.GA32605@earth.universe>
 <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMP44s3c68z-+3j9OR3pyBFVzH-LJ7WcMu-BnejhkfrxnF4rqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Sebastian Reichel <sre@debian.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 10, 2011 at 05:59:57PM +0200, Felipe Contreras wrote:

> It was not working for me, but it seems the problem was related to
> mdev/udev; snd_soc_tlv320aic3x has to be loaded before snd-soc-rx51.

That should not be required, the modules should be loadable in any
order.
