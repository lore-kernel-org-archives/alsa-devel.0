From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_ii/iv 3/3] ASoC: Extend DAPM to handle power
 changes on cross-device paths
Date: Mon, 1 Nov 2010 13:43:05 -0400
Message-ID: <20101101174305.GC24814@opensource.wolfsonmicro.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
	<1288353742-22005-3-git-send-email-jhnikula@gmail.com>
	<20101029210309.GI3921@opensource.wolfsonmicro.com>
	<20101031201153.453f8294.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D983C103824
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 18:42:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101031201153.453f8294.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 31, 2010 at 08:11:53PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > On Fri, Oct 29, 2010 at 03:02:22PM +0300, Jarkko Nikula wrote:

> > > Functions dapm_seq_run and dapm_seq_run_coalesced are modified so that a new
> > > write is issued when the sequence extends to an another device and DAPM
> > > context of a widget instead of originating DAPM context is used when doing
> > > pop waits and register writes.

> > I'm having a hard time parsing this bit of the changelog, I'm afraid.
> > What I'd expect is that the comparison operation used for coalescing
> > would be extended to compare based on the CODEC/DAPM context too and the
> > split per device should naturally fall out of that.  I didn't notice the
> > comparison being updated?

> It was these diffs for dapm_seq_run:

> 		/* Do we need to apply any queued changes? */
> -		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
> +		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
> +		    w->dapm != cur_dapm) {
>  			if (!list_empty(&pending))
>  				dapm_seq_run_coalesced(dapm, &pending);

> So if DAPM is different the dapm_seq_run_coalesced is run now and next
> iterations are done for another DAPM context.

Pretty much - that was the code I was looking for but you were talking
about only the execution code, not the comparison operation.
