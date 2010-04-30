From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for turning
 off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 12:42:27 +0100
Message-ID: <20100430114227.GF28241@rakim.wolfsonmicro.main>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<201004301310.14378.peter.ujfalusi@nokia.com>
	<20100430102309.GD21607@sirena.org.uk>
	<201004301355.25797.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 907702446D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 13:42:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004301355.25797.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 01:55:25PM +0300, Peter Ujfalusi wrote:

> I need to keep the dac33_pcm_prepare level of configuration for cases, when the 
> codec is in ON and a playback is starting (and if the codec is not ON, than 
> respond it for later, when it is switch on), right?
> I _need_ to do the things, which is done in the dac33_prepare_chip function 
> every time, when a stream is starting :(

Yes, absolutely - and if we add a post-DAPM prepare callback then you
can just do that there without worrying about power in the driver.

> I do agree, that it is not really nice to have playback related thing in the 
> dac33_set_bias_level, but so far I think that is the only way to avoid 
> additional hassle (which means more places to have error, problems).

Like I say, I think the addition of a post-DAPM callback on prepare
ought to do the job just as well.
