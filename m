From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:09:37 +0000
Message-ID: <20100112140936.GH1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5hockzmo1t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA6D21038A3
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:09:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hockzmo1t.wl%tiwai@suse.de>
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

On Tue, Jan 12, 2010 at 02:48:46PM +0100, Takashi Iwai wrote:

> Other low-hanging fruits:

>   sound/soc/codecs/da7210.c:499: warning: 'da7210_i2c_remove' defined but not used
>   sound/soc/codecs/tlv320dac33.c:1349: warning: 'dac33_i2c_remove' defined but not used
>   sound/soc/codecs/tpa6130a2.c:483: warning: 'tpa6130a2_remove' defined but not used

> Should be easily fixed by adding __devexit (and better with __devinit)
> properly.

What config do you use to generate these warnings?  None of mine
generate them.
