From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCHv2] ASoC: Overhaul Samsung drivers
Date: Fri, 22 Oct 2010 23:08:35 +0900
Message-ID: <006f01cb71f2$a0136100$e03a2300$%kim@samsung.com>
References: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A353E103810
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 16:08:19 +0200 (CEST)
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0LAP009BA39RVLD0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 22 Oct 2010 23:08:15 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LAP00C5O39RGY@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Fri, 22 Oct 2010 23:08:16 +0900 (KST)
In-reply-to: <1287736238-11846-1-git-send-email-jassisinghbrar@gmail.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jassi Brar' <jassisinghbrar@gmail.com>, alsa-devel@alsa-project.org
Cc: 'Jassi Brar' <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, mcuelenaere@gmail.com, cw00.choi@samsung.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Hi,
> 
Hi,

> Submitting revised patch series.
> 
> Patches 11 through 16 apply to Kgene's tree, rest apply to
> Mark Brown's.
> 
Hmm...

I faced with following build error after applying above 6 patches into my
tree.
It means can't make clean tree with only arch/arm patches?...
NO...just need to update arch/arm/plat-samsung/include/plat/audio.h of your
10/24 patch.
Please separate 10/24...there is no reason that to change plat/audio.h
belong to 10/24(Add common I2S driver)

arch/arm/mach-s3c64xx/dev-audio.c:77: error: unknown field 'type' specified
in initializer
arch/arm/mach-s3c64xx/dev-audio.c:77: error: extra brace group at end of
initializer
arch/arm/mach-s3c64xx/dev-audio.c:77: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:78: error: extra brace group at end of
initializer
arch/arm/mach-s3c64xx/dev-audio.c:78: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:81: warning: excess elements in struct
initializer
arch/arm/mach-s3c64xx/dev-audio.c:81: warning: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:144: error: unknown field 'type' specified
in initializer
arch/arm/mach-s3c64xx/dev-audio.c:144: error: extra brace group at end of
initializer
arch/arm/mach-s3c64xx/dev-audio.c:144: error: (near initialization for
'i2sv4_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:145: error: extra brace group at end of
initializer
arch/arm/mach-s3c64xx/dev-audio.c:145: error: (near initialization for
'i2sv4_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:146: error: 'QUIRK_PRI_6CHAN' undeclared
here (not in a function)
arch/arm/mach-s3c64xx/dev-audio.c:149: warning: excess elements in struct
initializer
arch/arm/mach-s3c64xx/dev-audio.c:149: warning: (near initialization for
'i2sv4_pdata')
arch/arm/mach-s3c64xx/dev-audio.c:151: error: expected expression before
'struct'
arch/arm/mach-s3c64xx/dev-audio.c:151: warning: excess elements in struct
initializer
arch/arm/mach-s3c64xx/dev-audio.c:151: warning: (near initialization for
'i2sv4_pdata')

arch/arm/mach-s5p6442/dev-audio.c:52: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5p6442/dev-audio.c:52: error: extra brace group at end of
initializer
arch/arm/mach-s5p6442/dev-audio.c:52: error: (near initialization for
'i2sv35_pdata')
arch/arm/mach-s5p6442/dev-audio.c:53: error: extra brace group at end of
initializer
arch/arm/mach-s5p6442/dev-audio.c:53: error: (near initialization for
'i2sv35_pdata')
arch/arm/mach-s5p6442/dev-audio.c:54: error: 'QUIRK_SEC_DAI' undeclared here
(not in a function)
arch/arm/mach-s5p6442/dev-audio.c:54: error: 'QUIRK_NEED_RSTCLR' undeclared
here (not in a function)
arch/arm/mach-s5p6442/dev-audio.c:57: warning: excess elements in struct
initializer
arch/arm/mach-s5p6442/dev-audio.c:57: warning: (near initialization for
'i2sv35_pdata')
arch/arm/mach-s5p6442/dev-audio.c:100: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5p6442/dev-audio.c:100: error: extra brace group at end of
initializer
arch/arm/mach-s5p6442/dev-audio.c:100: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5p6442/dev-audio.c:101: error: extra brace group at end of
initializer
arch/arm/mach-s5p6442/dev-audio.c:101: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5p6442/dev-audio.c:104: warning: excess elements in struct
initializer
arch/arm/mach-s5p6442/dev-audio.c:104: warning: (near initialization for
'i2sv3_pdata')

arch/arm/mach-s5p64x0/dev-audio.c:45: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5p64x0/dev-audio.c:45: error: extra brace group at end of
initializer
arch/arm/mach-s5p64x0/dev-audio.c:45: error: (near initialization for
's5p64x0_i2s_pdata')
arch/arm/mach-s5p64x0/dev-audio.c:46: error: extra brace group at end of
initializer
arch/arm/mach-s5p64x0/dev-audio.c:46: error: (near initialization for
's5p64x0_i2s_pdata')
arch/arm/mach-s5p64x0/dev-audio.c:47: error: 'QUIRK_PRI_6CHAN' undeclared
here (not in a function)
arch/arm/mach-s5p64x0/dev-audio.c:50: warning: excess elements in struct
initializer
arch/arm/mach-s5p64x0/dev-audio.c:50: warning: (near initialization for
's5p64x0_i2s_pdata')

arch/arm/mach-s5pc100/dev-audio.c:49: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5pc100/dev-audio.c:49: error: extra brace group at end of
initializer
arch/arm/mach-s5pc100/dev-audio.c:49: error: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pc100/dev-audio.c:50: error: extra brace group at end of
initializer
arch/arm/mach-s5pc100/dev-audio.c:50: error: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pc100/dev-audio.c:51: error: 'QUIRK_PRI_6CHAN' undeclared
here (not in a function)
arch/arm/mach-s5pc100/dev-audio.c:51: error: 'QUIRK_SEC_DAI' undeclared here
(not in a function)
arch/arm/mach-s5pc100/dev-audio.c:52: error: 'QUIRK_NEED_RSTCLR' undeclared
here (not in a function)
arch/arm/mach-s5pc100/dev-audio.c:55: warning: excess elements in struct
initializer
arch/arm/mach-s5pc100/dev-audio.c:55: warning: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pc100/dev-audio.c:98: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5pc100/dev-audio.c:98: error: extra brace group at end of
initializer
arch/arm/mach-s5pc100/dev-audio.c:98: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5pc100/dev-audio.c:99: error: extra brace group at end of
initializer
arch/arm/mach-s5pc100/dev-audio.c:99: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5pc100/dev-audio.c:102: warning: excess elements in struct
initializer
arch/arm/mach-s5pc100/dev-audio.c:102: warning: (near initialization for
'i2sv3_pdata')

arch/arm/mach-s5pv210/dev-audio.c:50: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5pv210/dev-audio.c:50: error: extra brace group at end of
initializer
arch/arm/mach-s5pv210/dev-audio.c:50: error: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pv210/dev-audio.c:51: error: extra brace group at end of
initializer
arch/arm/mach-s5pv210/dev-audio.c:51: error: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pv210/dev-audio.c:52: error: 'QUIRK_PRI_6CHAN' undeclared
here (not in a function)
arch/arm/mach-s5pv210/dev-audio.c:52: error: 'QUIRK_SEC_DAI' undeclared here
(not in a function)
arch/arm/mach-s5pv210/dev-audio.c:53: error: 'QUIRK_NEED_RSTCLR' undeclared
here (not in a function)
arch/arm/mach-s5pv210/dev-audio.c:56: warning: excess elements in struct
initializer
arch/arm/mach-s5pv210/dev-audio.c:56: warning: (near initialization for
'i2sv5_pdata')
arch/arm/mach-s5pv210/dev-audio.c:99: error: unknown field 'type' specified
in initializer
arch/arm/mach-s5pv210/dev-audio.c:99: error: extra brace group at end of
initializer
arch/arm/mach-s5pv210/dev-audio.c:99: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5pv210/dev-audio.c:100: error: extra brace group at end of
initializer
arch/arm/mach-s5pv210/dev-audio.c:100: error: (near initialization for
'i2sv3_pdata')
arch/arm/mach-s5pv210/dev-audio.c:103: warning: excess elements in struct
initializer
arch/arm/mach-s5pv210/dev-audio.c:103: warning: (near initialization for
'i2sv3_pdata')

Unfortunately, not yet cleaned after applying to change plat/audio.h...

arch/arm/mach-s3c64xx/dev-audio.c:151: error: expected expression before
'struct'
arch/arm/mach-s3c64xx/dev-audio.c:151: warning: excess elements in struct
initializer
arch/arm/mach-s3c64xx/dev-audio.c:151: warning: (near initialization for
'i2sv4_pdata')

-> missing brace :-(

arch/arm/mach-s5pv210/dev-audio.c:52: error: unknown field 'quriks'
specified in initializer

-> typo?...quirks...

Please add plat/audio.h patch and update them.

> Since v1:
> a) Use case 16 in set_bfs and default for error
> b) Better code comments.
> c) Use switch case in i2sv2_i2s_set_clkdiv
> d) Use SNDRV_PCM_RATE_8000_96000
> e) MAX_I2S -> SAMSUNG_I2S_SECOFF
> f) Local namespace cleanup with i2s driver.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
