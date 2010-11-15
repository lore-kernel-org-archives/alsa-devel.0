From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 14:06:05 +0000
Message-ID: <20101115140604.GD12986@rakim.wolfsonmicro.main>
References: <4CE126FD.7000407@elproma.com.pl>
	<20101115123351.GB3338@sirena.org.uk>
	<4CE139CF.4070400@elproma.com.pl>
	<20101115135053.GC3338@sirena.org.uk>
	<4CE13DC8.30007@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 634A510385A
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 15:06:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE13DC8.30007@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 03:03:52PM +0100, Grzegorz Daniluk wrote:
> Mark Brown wrote:

> >Could you please verify that you have enabled the debug logging
> >requested?  I cannot see any of the additional logging that would be
> >generated if this was enabled.

> If I understood correctly my sound/soc/soc-core.c looks as following
> (added #define ...):
> ....
> #include <sound/pcm.h>
> #include <sound/pcm_params.h>
> #include <sound/soc.h>
> #include <sound/soc-dapm.h>
> #include <sound/initval.h>
> 
> #define NAME_SIZE       32
> 
> /*my code*/
> #define CONFIG_DEBUG_FS

This should be selected via Kconfig; doing this here is going to be
actively harmful.

> #define DEBUG
> /*end of my code*/

You need to enable this at the *top* of the file rather than part way
through it - in particular, it needs to be before any #includes.
