From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Why no Marco definitions for rate 24000 and 12000?
Date: Fri, 14 Nov 2008 10:14:26 +0000
Message-ID: <20081114101425.GC21573@sirena.org.uk>
References: <458a17f90811140032v55c958bfiec1bf69bfb022873@mail.gmail.com>
	<458a17f90811140101q7d030c69k39c25552e87d1224@mail.gmail.com>
	<s5h7i76k4zc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A3932103838
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 11:14:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i76k4zc.wl%tiwai@suse.de>
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
Cc: cocala <syy.wxd@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 10:54:15AM +0100, Takashi Iwai wrote:
> cocala wrote:

> > but the macro definitions are still needed, actually 12000 and 24000 are
> > supported by most audio codecs.

> Simply pass SNDRV_PCM_RATE_KNOT instead of explicit rate bits.

This is with ASoC - due to the way the core does rate matching it'll
also require the platform side to support SNDDRV_PCM_RATE_KNOT (but
should work otherwise, both drivers will get the chance to define extra
constraints).
