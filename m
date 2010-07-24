From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: asoc multi-component: CPU DAI name is wrong
Date: Sat, 24 Jul 2010 10:42:47 +0100
Message-ID: <1279964567.3097.5.camel@odin>
References: <4C48BEBA.8080207@freescale.com> <1279908983.3076.8.camel@odin>
	<4C49E5C7.8020500@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A277243A7
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Jul 2010 11:42:50 +0200 (CEST)
Received: by wwb22 with SMTP id 22so3710586wwb.20
	for <alsa-devel@alsa-project.org>; Sat, 24 Jul 2010 02:42:49 -0700 (PDT)
In-Reply-To: <4C49E5C7.8020500@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-07-23 at 13:56 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> > My mistake, I'd missed something in the forward port. I've fixed the DAI
> > naming problem and you should see your DAI use the correct name.
> 
> Looks like you forgot something:
> 
>   CC      sound/soc/soc-core.o
> sound/soc/soc-core.c: In function 'snd_soc_register_dai':
> sound/soc/soc-core.c:2872: error: 'struct snd_soc_dai' has no member named 'id'
> sound/soc/soc-core.c: In function 'snd_soc_register_dais':
> sound/soc/soc-core.c:2949: error: 'struct snd_soc_dai' has no member named 'id'
> sound/soc/soc-core.c: In function 'snd_soc_register_platform':
> sound/soc/soc-core.c:3004: error: 'struct snd_soc_platform' has no member
> named 'id'
> sound/soc/soc-core.c: In function 'snd_soc_register_codec':
> sound/soc/soc-core.c:3102: error: 'struct snd_soc_codec' has no member named
> 'id'
> make[2]: *** [sound/soc/soc-core.o] Error 1
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 

Sorry, now fixed. Sound had somehow been disabled in my upstream .config
and hence would build kernels.

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
