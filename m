From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: DAPM: Allow multiple mixer sources to be
 routed via the same switch
Date: Tue, 16 Aug 2011 08:25:51 +0900
Message-ID: <20110815232549.GA14003@opensource.wolfsonmicro.com>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313432124-22591-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 15, 2011 at 08:15:21PM +0200, Lars-Peter Clausen wrote:
> Currently it is only possible to route one source per switch into a mixer.
> This patch modifies the code, so that it is possible to route multiple sources
> into a mixer via the same switch. One use-case for this is routing a stereo
> channel pair into a mono-mixer via the same switch.

Applied, thanks.
