From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Check for exact register match
	in wm97xx_reset()
Date: Fri, 13 Jun 2008 16:19:02 +0100
Message-ID: <20080613151901.GB2853@sirena.org.uk>
References: <1213367953-32239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hskvhqsj9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B79C1037FD
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:19:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskvhqsj9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2008 at 05:11:06PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> >  	soc_ac97_ops.reset(codec->ac97);
> > -	if (ac97_read(codec, 0) & 0x8000)
> > +	if (ac97_read(codec, 0) != 0x6174)

> Can we define this magic value more understandable?

It's the default value for the (non-modifiable) register - building it
up from a bitmask with semantics isn't particularly meaningful.  The
only thing I can think is to just reference the register cache default
values, I'll resend in a minute or two.
