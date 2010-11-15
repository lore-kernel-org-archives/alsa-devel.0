From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: AT73C213: Rectify
	misleading	comments.
Date: Mon, 15 Nov 2010 19:16:42 +0000
Message-ID: <20101115191642.GG3338@sirena.org.uk>
References: <1289820546-2078-1-git-send-email-peda@axentia.se>
	<1289832634.18691.1.camel@hcegtvedt>
	<4CE1816F.6080000@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A4BF24545
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 20:16:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE1816F.6080000@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 07:52:31PM +0100, Peter Rosin wrote:
> Den 2010-11-15 15:50 skrev Hans-Christian Egtvedt:

> > IIRC the bitrate is controlled by a generic clock, and it has a power of
> > two divider possibility. Hence the comment about power of two.

> My point is that the "ssc_div must be a power of 2" comment is
> misleading in that this is an external (to the driver) constraint that
> has nothing to do with the driver code.  This constraint is also not
> universally true, and the comment just makes it harder to follow what
> the driver code is doing.

This code probably ought to be converted to ASoC anyway :)
