From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Blackfin AC97: fix resume
 handling
Date: Tue, 14 Jul 2009 19:45:04 +0100
Message-ID: <20090714184503.GA4543@sirena.org.uk>
References: <1247580100-15726-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EDF12434F
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jul 2009 20:45:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247580100-15726-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2009 at 10:01:39AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> There is no need to manually start playback/capture ourselves as the PCM
> driver will handle things for us.

Applied both, thanks!
