From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Use delayed work for debounce of
	GPIO based jacks
Date: Thu, 7 Oct 2010 08:54:31 +0300
Message-ID: <20101007085431.879415b7.jhnikula@gmail.com>
References: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 624F42413B
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 07:53:49 +0200 (CEST)
Received: by ewy8 with SMTP id 8so136724ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Oct 2010 22:53:49 -0700 (PDT)
In-Reply-To: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed,  6 Oct 2010 16:05:01 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> Rather than block the workqueue by sleeping to do the debounce use delayed
> work to implement the debounce time. This should also mean that we extend
> the debounce time on each new bounce, potentially allowing shorter debounce
> times for clean insertions.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This is completely untested as I do not have any systems to hand which
> can make use of this functionality but I believe it should work - I've
> CCed a couple of the OMAP people since they seem to be the main users.
> 
>  include/sound/soc.h  |    2 +-
>  sound/soc/soc-jack.c |   11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
Works fine on N900 when testing with
hexdump /dev/input/by-path/platform-soc-audio-event

I have a vague memory that user space and actual state can get soon out
of sync if using delay based debouncing only and doing some insane plug
in/out cycle. So this is a step to right direction for implementing
more advanced debouncing.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
