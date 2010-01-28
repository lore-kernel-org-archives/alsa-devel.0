From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Modify codec default
	settings
Date: Thu, 28 Jan 2010 14:34:24 +0000
Message-ID: <20100128143424.GA10637@rakim.wolfsonmicro.main>
References: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CC3C81037EA
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 15:34:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2010 at 03:57:04PM +0200, Peter Ujfalusi wrote:
> Change the legacy default register configuration, which left some
> internal components on.
> Now we have either DAPM, or other ways to control these bits,
> so there is no need to enable them by default.

Applied, thanks.  Though if they're regular DAPM controls then they
should get turned off again during startup if they're not used.
