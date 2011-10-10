From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Convert H1940 to table based init
Date: Mon, 10 Oct 2011 11:10:16 +0100
Message-ID: <20111010101016.GB3607@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<016001cc8733$df55dd50$9e0197f0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EF6F2448D
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 12:10:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <016001cc8733$df55dd50$9e0197f0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 10, 2011 at 07:03:34PM +0900, Sangbeom Kim wrote:

> Minor question:
> Is there any reason for adding new line?

To break up the big table - when they start getting too large they can
be hard to read.  Most of these ones aren't too big but keeping a
similar pattern makes working over the whole tree easier.
