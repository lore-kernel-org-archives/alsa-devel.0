From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Tue, 30 Mar 2010 10:40:43 +0100
Message-ID: <20100330094042.GB2012@rakim.wolfsonmicro.main>
References: <1269613142-23942-1-git-send-email-marek.vasut@gmail.com>
	<20100329124808.GA8434@rakim.wolfsonmicro.main>
	<201003292316.11828.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEAF22463C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Mar 2010 11:40:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201003292316.11828.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 29, 2010 at 11:16:11PM +0200, Marek Vasut wrote:

> ok, shall I send that in another patch and CC linux-arm ?

It should be merged into the same patch but yes, or to mitigate against
merge issues you could do the registration in the ASoC machine drivers
then merge to arch/arm in a second round later.
