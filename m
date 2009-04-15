From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: pxa-ssp: allow setting of dai format
	0
Date: Wed, 15 Apr 2009 22:32:11 +0100
Message-ID: <20090415213211.GA6586@sirena.org.uk>
References: <1239819885-25964-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A631A103816
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 23:32:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239819885-25964-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 08:24:45PM +0200, Daniel Mack wrote:
> pxa_ssp_set_dai_fmt() currently has an early exit if the desired format
> equals the current configuration. This is correct behaviour unless this
> function is called with a zero value parameter for the first time.
> Zero is a valid value for this function, but the early exit is bogus in
> this case.

Applied, thanks.
