From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: JZ4740: Fix i2s shutdown
Date: Tue, 3 May 2011 18:48:44 +0100
Message-ID: <20110503174844.GI1762@opensource.wolfsonmicro.com>
References: <1304195300-5483-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 066BF1038CF
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 19:48:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304195300-5483-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 30, 2011 at 10:28:20PM +0200, Lars-Peter Clausen wrote:
> The i2s shutdown callback has the check whether it should be disabled reversed.
> Currently it is disabled if another stream is still active, but kept enabled if
> the last stream is closed. This patch fixes it.

Applied, thanks.
