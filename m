From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: CS4270: export de-emphasis
 filter as ALSA control
Date: Thu, 29 Oct 2009 10:15:13 +0000
Message-ID: <20091029101512.GA3902@rakim.wolfsonmicro.main>
References: <1256779472-30754-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A8B024664
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 11:15:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256779472-30754-1-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2009 at 02:24:32AM +0100, Daniel Mack wrote:
> The CS4270 codec features an de-emphasis filter for compensation of
> audio material filtered by an 50/15 uS algorithm. Not sure whether we
> should always enable it for 44100Hz sampling frequency, but it should at
> least be configurable by the user.

It shouldn't be automatically enabled - historically some sources put
some preemphasis on the recording in order to compensate for poor
playback technologies but it's vanishingly rare to encounter any such
sources these days.

I'll apply this.
