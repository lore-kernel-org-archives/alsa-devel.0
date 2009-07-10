From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH for-2.6.32] sound dapm: fix checking for
 external widgets bug
Date: Fri, 10 Jul 2009 20:19:26 +0100
Message-ID: <20090710191925.GA5916@sirena.org.uk>
References: <90B0CE4312136749B97EBEAF5764F87403C8F77A@ambarella-ex.ambarella.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D9535243F9
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 21:19:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <90B0CE4312136749B97EBEAF5764F87403C8F77A@ambarella-ex.ambarella.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rongrong Cao <rrcao@ambarella.com>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 07, 2009 at 11:11:46PM -0700, Rongrong Cao wrote:
> From: Rongrong Cao rrcao@ambarella.com

> This patch is based on for-2.6.32
> In SOC DAPM layer of SOUND subsystem, when add signal route (in the function snd_soc_dapm_add_route() ), 
> the original code has wrong logic when dapm layer check each widget whether an external one.

This still doesn't apply.  It looks like your MUA is corrupting the
patch - it's MIME encoded everything and replaced all the tabs with
spaces which is causing all the patch application programs I have to get
confused.  Documentation/email-clients.txt has some suggestions on how
to configure various MUAs to send patches cleanly.  Personally I always
use git send-email.  You probably also want to have a look at the
instructions in Documentation/SubmittingPatches with regard to the
formatting of your patch - the main thing being that the Signed-off-by
should go before the patch content.

In any case, I've manually applied the patch so no need to resubmit it.

I also notice that you've CCed trivial@kernel.org.  Please don't do that
except for things that can't possibly cause bugs - a change like this
doesn't really qualify since while the code clearly looks buggy it's
always possible that the code is just obscure.
