From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/1] sgtl5000: Fix suspend/resume
Date: Wed, 6 Apr 2011 08:23:53 +0900
Message-ID: <20110405232352.GB6775@opensource.wolfsonmicro.com>
References: <87aag5m8rn.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC3E01037F8
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 01:23:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87aag5m8rn.fsf@lebrac.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 05, 2011 at 09:56:12AM +0200, Arnaud Patard wrote:

> Which means that reg cache size is SGTL5000_MAX_REG_OFFSET / 2 and
> register values stored without any "holes" in the array, except that in
> flat cache case, ASoC does :

> static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
>                                    unsigned int reg, unsigned int
>                                    *value)
> {
>         *value = snd_soc_get_cache_val(codec->reg_cache, reg,
>                                        codec->driver->reg_word_size);
>         return 0;
> }

> and snd_soc_get_cache_val returns cache[reg] which means that the cache
> size must have a length of SGTL5000_MAX_REG_OFFSET and values stored
> with "holes".

But this means that _get_cache_val() needs to be fixed to take account
of the register cache step size.  We shouldn't just pad the array, that
doesn't help.
