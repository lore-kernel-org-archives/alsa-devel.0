From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.33
Date: Mon, 25 Jan 2010 15:41:00 +0000
Message-ID: <20100125154100.GB30102@sirena.org.uk>
References: <20100125144946.GA27616@rakim.wolfsonmicro.main>
	<s5hiqaqw61p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 694B324629
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 16:41:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqaqw61p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 25, 2010 at 04:36:02PM +0100, Takashi Iwai wrote:

> So, basically you restore the value changed between the beginning of
> the resume and after the call of wm8903_set_bias_levels().  What if
> the value was changed before the resume call?  Shouldn't it be like

> 			if (tmp_cache[i] != reg_cache[i] ||
> 			    tmp_cache[i] != wm8903_reg_defaults[i])
> 				snd_soc_write(codec, i, tmp_cache[i]);

> ??  Or maybe I misread the code?

It's fine as-is - the resume will reset the register cache to the
current state of the chip as part of the bringup so the effect of the
existing code will be to write back anything in tmp_cache which is not
present on the chip at the moment that the loop runs.  This will include
the effect of any changes prior to resume which weren't overwritten by
resume.
