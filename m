From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based board
 driver
Date: Thu, 27 Aug 2009 15:11:49 -0400 (EDT)
Message-ID: <47184.207.35.173.122.1251400309.squirrel@mail.colcan.ca>
References: <4A7DB844.3030303@fosstel.com>
	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>
	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
	<4A81BB75.3070405@fosstel.com> <20090811224132.GB4691@sirena.org.uk>
	<4A94200D.6080707@fosstel.com> <20090825182934.GA4317@sirena.org.uk>
	<4A943F86.5000601@fosstel.com> <20090826114458.GA14905@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 04E1F1037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Aug 2009 21:11:53 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=mail.colcan.ca)
	by a2s40.a2hosting.com with esmtpa (Exim 4.69)
	(envelope-from <psanchez@fosstel.com>) id 1MgkNx-00014f-70
	for alsa-devel@alsa-project.org; Thu, 27 Aug 2009 15:11:49 -0400
In-Reply-To: <20090826114458.GA14905@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On Tue, Aug 25, 2009 at 03:46:14PM -0400, Pedro I. Sanchez wrote:
>
>> The big quest for me now is to figure out what "cmr_div" and "period"
>> have to be. They must be different for each sample rate. Any pointers
>> would be appreciated.
>
> There should be a clocking diagram in the CPU manual which will show how
> things are interrelated.  The period of a clock will be 1/rate - the
> length of time taken for a clock cycle.
>

I'm still struggling with the clocks but in the mean time I have a related
question. Why is it that if I play a 24-bit encoded play the hw_params()
function in my driver is called with SNDRV_PCM_FORMAT_S16_LE format? Does
ALSA makes an on-the-fly conversion?

$ aplay c2_24.wav
Playing WAVE 'c2_24.wav' : Signed 24 bit Little Endian in 3bytes, Rate
44100 Hz, Mono

... and my ipspeaker machine driver module says:

Aug 27 15:03:15 ubuntu kernel: ipspeaker_hw_params: pcm rate is 44100
Aug 27 15:03:16 ubuntu kernel: ipspeaker_hw_params: PCM format
SNDRV_PCM_FORMAT_S16_LE

I would expect my driver to be told that the format is
SNDRV_PCM_FORMAT_S24_LE. Why is this?

Thanks,

-- 
Pedro
