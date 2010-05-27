From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] imx-ssi.c: fix I2S slave setup
Date: Thu, 27 May 2010 03:04:11 +0100
Message-ID: <20100527020411.GA26138@sirena.org.uk>
References: <1274891873-3704-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 76BA11039B1
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 04:04:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274891873-3704-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric B??nard <eric@eukrea.com>
Cc: s.hauer@pengutronix.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 06:37:53PM +0200, Eric B??nard wrote:
> * without this fix, the waveform on the SSI port are not real
> I2S signal (at least on i.MX27's SSI4)

BTW, please do also remember to CC maintainers on patches as documented
in Documentation/SubmittingPatches.
