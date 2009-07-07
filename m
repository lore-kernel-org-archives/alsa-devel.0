From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound dapm: fix check for external widgets
 bug (based on linux-2.6.30.1)
Date: Tue, 7 Jul 2009 19:39:48 +0100
Message-ID: <20090707183948.GA6681@sirena.org.uk>
References: <90B0CE4312136749B97EBEAF5764F87403C8F2D3@ambarella-ex.ambarella.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CDC55243FB
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 20:39:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <90B0CE4312136749B97EBEAF5764F87403C8F2D3@ambarella-ex.ambarella.net>
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

On Mon, Jul 06, 2009 at 05:55:27AM -0700, Rongrong Cao wrote:

> This patch is based on linux-2.6.30.1
> In SOC DAPM layer of SOUND subsystem, when add signal route (in the function snd_soc_dapm_add_route() ), 
> the original code has wrong logic when dapm layer check each widget whether an external one.

This looks like it's probably a good fix but doesn't apply against
current ASoC since there have been some changes in this area.  The
latest ASoC code can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Could you please regenerate (and ideally retest too) against that?

It may be useful to take a look at Documentation/SubmittingPatches for
details on how patches should normally be submitted.
