From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:37:48 +0000
Message-ID: <20100112143748.GB17092@sirena.org.uk>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5hockzmo1t.wl%tiwai@suse.de>
	<20100112140936.GH1418@rakim.wolfsonmicro.main>
	<s5hiqb7mmm6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 45A0A10382B
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:37:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqb7mmm6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2010 at 03:19:45PM +0100, Takashi Iwai wrote:

> They are from make allyesconfig with certain config files, such as
> ixp2000_defconfig or footbridge_defconfig.  For example,

> 	% cp arch/arm/configs/footbridge_defconfig .config
> 	% KCONFIG_ALLCONFIG=.config make ARCH=arm allyesconfig

Looks like CONFIG_HOTPLUG not being set is the culprit.
