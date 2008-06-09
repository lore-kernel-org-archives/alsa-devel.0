From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC PCM formats
Date: Mon, 9 Jun 2008 09:08:18 -0400
Message-ID: <9e4733910806090608p3b7a182fgaf1ac51ee13b8b5c@mail.gmail.com>
References: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
	<20080609091742.GA17278@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 575ED249D5
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 15:08:23 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1108780ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 09 Jun 2008 06:08:18 -0700 (PDT)
In-Reply-To: <20080609091742.GA17278@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6/9/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jun 06, 2008 at 08:00:04PM -0400, Jon Smirl wrote:
>
>  > Why is the AC97 format set to S16 in all of the drivers? The link is
>  > 20b and my codec takes 20b, how do I get 20b data to the device? I
>  > tried using SNDRV_PCM_FORMAT_S20_3BE but all I get is static.
>
>
> The format that is set needs to correspond to what your AC97 controller
>  needs as input.  The setting for the codec just needs to match one of
>  the supported ones for the controller - the specific memory layout of
>  the data should not be important, the controller ought to reformat the
>  data into whatever is appropriate for the bus.
>
>  This isn't entirely ideal but in practice works well since most
>  controllers need samples in pretty much the form they're outputing and
>  so the sample size in RAM usually needs to correspond to the sample size
>  that appears on the bus.
>
>  As Clemens said, try S32.
>

The format is in three places:
codec dai
platform dai
dma driver

Isn't the wm9712 an AC97 controller? on pxa..
codec dai = SNDRV_PCM_FMTBIT_S16  | SNDRV_PCM_FMTBIT_S24
platform_dai = SNDRV_PCM_FMTBIT_S16_LE
dma driver = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
SNDRV_PCM_FMTBIT_S32_LE,

I tried copying this. It sends 16 bit sound through the system.

I'll try this next..
codec dai = SNDRV_PCM_FMTBIT_S32
platform_dai = SNDRV_PCM_FMTBIT_S32_BE
dma driver = SNDRV_PCM_FMTBIT_S32_BE


-- 
Jon Smirl
jonsmirl@gmail.com
