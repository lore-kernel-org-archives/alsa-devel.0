From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Blackfin I2S: use dai state
 rather than local counter
Date: Wed, 23 Sep 2009 09:08:59 -0700
Message-ID: <20090923160858.GB8593@sirena.org.uk>
References: <1253721065-2785-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A0551038A3
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 18:09:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253721065-2785-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 23, 2009 at 11:51:04AM -0400, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>

> Since the active field of the dai already tells us the stream activity,
> the local counter variable is redundant and can be replaced.

> Signed-off-by: Barry Song <barry.song@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, for 2.6.33 - thanks.
