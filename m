From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC codec: SSM2602:
	remove	unsupported sample rates
Date: Wed, 3 Jun 2009 13:15:13 +0100
Message-ID: <20090603121513.GB25676@sirena.org.uk>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<20090603102605.GB11507@sirena.org.uk> <4A266878.2070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C591D24342
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:15:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A266878.2070206@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 02:11:36PM +0200, Karl Beldan wrote:

> These samples rates are supported by the codec, updating coeff_div
> would be a better move.

It looks like the driver only supports a limited subset of the chip
features as it is - there's also comments saying it supports asymmetric
configurations but currently the driver only does symmetric record and
playback setups.
