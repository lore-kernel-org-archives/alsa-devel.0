From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PATCH[1/1] Add I2S common driver for Intel MID
 platform
Date: Tue, 19 Oct 2010 16:18:30 -0700
Message-ID: <20101019231829.GF3803@opensource.wolfsonmicro.com>
References: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
	<20101019213212.GB29234@sirena.org.uk>
	<AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F05B244D4
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 01:18:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Le Gall,
	Louis" <louis.le.gall@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 05:48:23PM -0500, pl bossart wrote:

> Louis meant ALSA rather than ASOC. We use burst transfers to reduce
> round-trip delay, the whole notion of periods/period elapsed/ring
> buffer doesn't make sense here and there is in-band signalling that

Actually the burst mode stuff has been done with TLV320DAC33, though
more for power consumption reduction than for reducing RTT.

> should not be interpreted as samples. If ALSA had a simplified API for
> byte streams sent over a serial output, we would have no problems
> using it and of course ASOC would be used then.

Non-audio data in-band is more of a problem, though, as is data that
doesn't at the end of the day map down to periodic data.
