From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
	machines that use it.
Date: Thu, 15 Jan 2009 17:20:58 +0000
Message-ID: <20090115172057.GC12768@sirena.org.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DD46103878
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 18:21:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <496F0ABD.4080207@mnementh.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2009 at 10:06:53AM +0000, Ian Molton wrote:
> Takashi Iwai wrote:

> > We need reviews.  Could you post patches as well?

> Sure - attached below:

Always do this for ALSA patch submissions (the same thing will apply to
the majority of kernel subsystems).  Please also CC at least me on ASoC
patches.  I do read the list but it helps to make sure things don't get
missed.

These all look fine apart from one small thing in the codec driver and
the issue Russell already pointed out.

> +
> +	soc_ac97_ops.reset(codec->ac97);

This should check the return value, resets can and do fail.
