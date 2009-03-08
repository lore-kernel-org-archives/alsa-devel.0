From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC scenarii API
Date: Sun, 8 Mar 2009 19:17:56 +0000
Message-ID: <20090308191755.GA18035@sirena.org.uk>
References: <87iqojqvyq.fsf@free.fr> <20090113155602.GD11651@sirena.org.uk>
	<87tz82yh1c.fsf@free.fr> <87vdr5orpj.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CA2AF103806
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 20:18:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87vdr5orpj.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 20, 2009 at 08:04:24PM +0100, Robert Jarzmik wrote:

> As a side note, I'm a bit bothered by your comment about using
> "snd_ctl_elem_value" instead of integers in structure soc_scen_setup_mix. My
> concern is about size : snd_ctl_elem_value is huge, and as there will be many
> mixes/muxes, the memory print will be huge. Can't we deal with only integers for
> mixers and muxes ?

I don't think it'd be acceptable to limit this to only working with a
subset of controls, that'd mean that any controls that don't happen to
fit in an integer.  Allowing for a pointer to an out of line value would
deal with the size issue, I'd expect.
