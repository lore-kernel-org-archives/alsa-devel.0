From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
	controller
Date: Wed, 4 Feb 2009 12:00:52 +0000
Message-ID: <20090204120045.GB29849@sirena.org.uk>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F0E924356
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:08:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 04, 2009 at 12:48:34PM +0100, Hans-Christian Egtvedt wrote:
> This patch adds ALSA support for the AC97 controller found on Atmel
> AVR32 devices.

> Tested on ATSTK1006 + ATSTK1000 with a development board with a AC97
> codec.

> Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

Just glancing over the code here this looks very like the code for the
AT91 AC97 controller which Sedji (CCed) has posted in the past.  Is it
possible to share the same driver for both chips, like we're doing with
the ASoC drivers for the two architectures?  It'd make life easier if
that were possible and I know there's a lot of people interested in the
AT91 support for mainline.
