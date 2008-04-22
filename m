From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Add drivers for the Texas
	Instruments OMAP	processors
Date: Tue, 22 Apr 2008 15:43:31 +0100
Message-ID: <20080422144331.GB5242@rakim.wolfsonmicro.main>
References: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208870079-5325-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskxe9dvs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80431245D4
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 16:43:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskxe9dvs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 22, 2008 at 04:13:11PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Add common OMAP ASoC drivers and machine driver for Nokia N810. Currently
> > supported features are:

> I postpone this patch until 2.6.26 merge is closed.
> This is obviously a new stuff and it must be cooked for a while in mm
> tree.

The main reason why this is new is that it depends on the architecture
being added via the ARM tree - as with the PXA3xx AC97 changes it had
been waiting for the required patches to be submitted by rmk, which just
happened.  Given this it seems safe to merge it as-is - the entire
machine shares the same sort of testing status and the patch isn't new
in itself.
