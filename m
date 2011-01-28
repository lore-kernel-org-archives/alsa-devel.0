From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: fix kernel panic due to
 uninitialized platform_data
Date: Fri, 28 Jan 2011 12:25:24 +0000
Message-ID: <20110128122524.GA10350@opensource.wolfsonmicro.com>
References: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F11E524533
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 13:25:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296136063-31625-1-git-send-email-prakash.pm@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 07:17:43PM +0530, Manjunathappa, Prakash wrote:
> This patch fixes the Kernel panic issue on accessing davinci_vc in
> cq93vc_probe function. struct davinci_vc is part of platform device's
> private driver data(codec->dev->p->driver_data) and this is populated
> by DaVinci Voice Codec MFD driver.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied, thanks.
