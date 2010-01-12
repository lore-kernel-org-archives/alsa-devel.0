From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 13:42:23 +0000
Message-ID: <20100112134222.GF1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hzl4jmp1e.wl%tiwai@suse.de> <s5htyurmoof.wl%tiwai@suse.de>
	<s5hskabmofy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A1401038AA
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 14:42:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hskabmofy.wl%tiwai@suse.de>
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

On Tue, Jan 12, 2010 at 02:40:17PM +0100, Takashi Iwai wrote:
> I wrote:

> > I got a build error quickly:

> Yet another one.

>   sound/soc/s3c24xx/neo1973_gta02_wm8753.c: In function 'lm4853_set_spk':
>   sound/soc/s3c24xx/neo1973_gta02_wm8753.c:244: error: 'S3C2440_GPJ2' undeclared (first use in this function)
>   sound/soc/s3c24xx/neo1973_gta02_wm8753.c:244: error: (Each undeclared identifier is reported only once

This is a cross-tree merge issue, the relevant defines are present in
the ARM tree.  I'm not too worried about this one, you'll need to build
for that one specific machine to run into it.
