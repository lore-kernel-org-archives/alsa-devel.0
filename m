From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_ii/iv 3/3] ASoC: Extend DAPM to handle power
 changes on cross-device paths
Date: Sun, 31 Oct 2010 20:11:53 +0200
Message-ID: <20101031201153.453f8294.jhnikula@gmail.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
	<1288353742-22005-3-git-send-email-jhnikula@gmail.com>
	<20101029210309.GI3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F71A1037FF
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 19:10:31 +0100 (CET)
Received: by ewy22 with SMTP id 22so2430312ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 11:10:30 -0700 (PDT)
In-Reply-To: <20101029210309.GI3921@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010 14:03:10 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 29, 2010 at 03:02:22PM +0300, Jarkko Nikula wrote:
> 
> > Functions dapm_seq_run and dapm_seq_run_coalesced are modified so that a new
> > write is issued when the sequence extends to an another device and DAPM
> > context of a widget instead of originating DAPM context is used when doing
> > pop waits and register writes.
> 
> I'm having a hard time parsing this bit of the changelog, I'm afraid.
> What I'd expect is that the comparison operation used for coalescing
> would be extended to compare based on the CODEC/DAPM context too and the
> split per device should naturally fall out of that.  I didn't notice the
> comparison being updated?
> 
It was these diffs for dapm_seq_run:

		/* Do we need to apply any queued changes? */
-		if (sort[w->id] != cur_sort || w->reg != cur_reg) {
+		if (sort[w->id] != cur_sort || w->reg != cur_reg ||
+		    w->dapm != cur_dapm) {
 			if (!list_empty(&pending))
 				dapm_seq_run_coalesced(dapm, &pending);

So if DAPM is different the dapm_seq_run_coalesced is run now and next
iterations are done for another DAPM context.

Looking at this now I think I can leave out dapm_seq_run_coalesced
changes by changing the line above to
dapm_seq_run_coalesced(cur_dapm, &pending). I'll check it for the
next version.

> Otherwise this looks pretty good, these are stylistic things:
> 
Good notes. I'll change them.


-- 
Jarkko
