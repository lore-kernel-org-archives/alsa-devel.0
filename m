From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add ADAV80x codec driver
Date: Fri, 24 Jun 2011 13:00:41 +0100
Message-ID: <20110624120040.GD9483@opensource.wolfsonmicro.com>
References: <1308808818-26775-1-git-send-email-lars@metafoo.de>
 <4E0332C5.7010608@ti.com>
 <4E03DDEC.9060608@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E03DDEC.9060608@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lrg@ti.com>, Mike Frysinger <vapier.adi@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2011 at 02:44:28AM +0200, Lars-Peter Clausen wrote:
> On 06/23/2011 02:34 PM, Liam Girdwood wrote:

> > It's usually better disable things like sysclk output in your machine driver as others may depend on it for probing.

> What is the proper API to do this? set_sysclk with dir = SND_SOC_CLOCK_OUT and
> freq = 0?

Something like that, yes.
