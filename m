From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: UDA134X: Fix mistaken mute/unmute
 code
Date: Mon, 17 Aug 2009 11:59:57 +0100
Message-ID: <20090817105956.GA19396@rakim.wolfsonmicro.main>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
	<1250506321.1932.7.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26A2B10381B
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 12:59:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250506321.1932.7.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 17, 2009 at 06:52:01PM +0800, Shine Liu wrote:
> Resend the patch for the mistaken mute/unmute code.

> Signed-off-by: Shine Liu <shinel@foxmail.com>

I've applied this after copying the changelog from your previous patch.

> --- sound/soc/codecs/uda134x.c.orig	2009-07-14 09:18:52.000000000 +0800
> +++ sound/soc/codecs/uda134x.c	2009-08-17 13:46:57.000000000 +0800

Please also see Documentation/SubmittingPatches - patches should be
generated to be applied with patch -p1.
