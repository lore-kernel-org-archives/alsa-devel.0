From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] ASoC: ad193x: fix system clock
Date: Mon, 15 Aug 2011 22:35:50 +0900
Message-ID: <20110815133547.GJ3927@opensource.wolfsonmicro.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
	<1313186654-22520-3-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 937282462E
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:35:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313186654-22520-3-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 06:04:12PM -0400, Scott Jiang wrote:
> system clock is 24.576MHz instead of 12.288MHz

>  sound/soc/blackfin/bf5xx-ad193x.c |    2 +-

This is not a patch for the ad193x driver at all, this is a patch to
one of the Blackfin machine drivers.  Please make more effort with your
changelogs all round, I've applied this time but it took a bit of time
to work out what you're trying to do here.

Looking at the code I suspect you want a default case in this switch
statement which returns an error as nothing else really makes sense -
the current code just looks broken.
