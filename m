From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
 snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 15:43:08 +0000
Message-ID: <20111122154308.GG6624@sirena.org.uk>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
	<20111122140210.GD6624@sirena.org.uk> <4ECBBE59.2040703@gmail.com>
	<20111122153539.GF6624@sirena.org.uk>
	<4ECBC1D6.9090301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 20EAE103BBB
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 16:43:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ECBC1D6.9090301@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Sven@alsa-project.org, alsa-devel@alsa-project.org, Neumann <s.neumann@raumfeld.com>, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 09:37:58AM -0600, Timur Tabi wrote:

> Is there a quick-and-dirty way to test suspend/resume?  It's not
> officially supported on our board with a CS4270, so I never tried it,
> and I'm not familiar with it.

No, not really.  Nearest thing would be to enable idle_bias_off and then
do the stuff you currently do in suspend and resume in the bias
management (which might not be a bad idea actually, unless there's pops
when powering off and on it'll probably save some power).
