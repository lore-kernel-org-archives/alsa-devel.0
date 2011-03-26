From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] Fix breakages due to recent updates
Date: Sat, 26 Mar 2011 17:42:05 +0000
Message-ID: <20110326174204.GH3535@opensource.wolfsonmicro.com>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
	<20110326173546.GA17962@sirena.org.uk>
	<20110326174040.GA20964@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F16C910387D
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 18:41:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110326174040.GA20964@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 26, 2011 at 06:40:40PM +0100, Wolfram Sang wrote:

> Yes. Do you (or someone) happen to have a script ready which sends the
> cover-letter to the same people which get later added to the patches with
> --cc-cmd='script/maintainers.pl'?

My strong recommendation would be to never blindly use the output of
check_maintainers.pl directly in the first place but I'd exepect that
using the cover letter feature of git send-mail might do the trick.
