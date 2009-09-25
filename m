From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Problem with mplayer and OSS on at91sam9g20(kernel
	2.6.30)
Date: Fri, 25 Sep 2009 07:28:37 -0700
Message-ID: <A6B4CA7C-DA92-47A7-B5C0-2668E8CA7FF2@opensource.wolfsonmicro.com>
References: <4ABB67CA.6000003@atmel.com> <20090924145755.GB5105@sirena.org.uk>
	<4ABC6B34.7080200@ladisch.de>
	(sfid-20090925_080742_312890_600E81AE)
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15A0D103901
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 16:28:43 +0200 (CEST)
In-Reply-To: <4ABC6B34.7080200@ladisch.de>
	(sfid-20090925_080742_312890_600E81AE)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 25 Sep 2009, at 00:03, Clemens Ladisch <clemens@ladisch.de> wrote:

> Mark Brown wrote:
>> I'd expect it's getting upset because it's being called with an
>> invalid rate (OSS emulation calls hw_params with partially  
>> initialised
>> parameters)
>
> But even the uninitialized parameters conform to the constraints that
> were set by the driver, so they should never be invalid.

ASoC drivers, particularly ones doing manual clocking like this one,  
don't always express their full constraints to the application (in  
some cases it'd be far too hard).

> Sedji, try running mplayer with -v, this should give more log messages
> with the parameters that mplayer is trying to set.
>
>
> Best regards,
> Clemens
