From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 5/5] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Mon, 10 Aug 2009 17:32:19 -0700
Message-ID: <4A80BC13.2040808@boundarydevices.com>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
	<4A7B8C02.6020902@boundarydevices.com>
	<20090808091708.GG4519@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth03.csee.onr.siteprotect.com
	(smtpauth03.csee.onr.siteprotect.com [64.26.60.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B3B610380C
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 02:32:37 +0200 (CEST)
In-Reply-To: <20090808091708.GG4519@sirena.org.uk>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Aug 06, 2009 at 07:05:54PM -0700, Troy Kisky wrote:
> 
>> This is allocated too late for the "ensure that buffer size is a multiple of period size"
>> constraint.
> 
>> I have a patch after fixing other feedback.
> 
> It looks good to me - I've no issues with the patch except for the one I
> mentioned last time about considering ignoring the data in SRAM when
> reporting the current position but I'm happy either way.  The patch will
> run into the cross tree issues with the platform data like the channel
> combining one, probably best to submit patches against Kevin's tree for
> now (or wait until after the merge window).
> 
> Have you tested with PulseAudio?  If not it'd be worth giving it a spin
> - it's one of the more demanding applications.
> 
I haven't tested with PulseAudio, and I don't have time to look into it currently.
Any volunteers?

On question I had concerns davinci_pcm_hardware. It is currently for both playback
and capture. Since allocate_sram contains "davinci_pcm_hardware.period_bytes_max = size;,"
should I change davinci_pcm_hardware to playback_pcm_hardware, capture_pcm_hardware?
