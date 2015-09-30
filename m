From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 12:08:20 -0700
Message-ID: <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
 <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
 <20150930181004.GN15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com
 [209.85.213.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DDCE266415
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:08:23 +0200 (CEST)
Received: by vkgd64 with SMTP id d64so28128708vkg.0
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 12:08:20 -0700 (PDT)
In-Reply-To: <20150930181004.GN15635@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, =?UTF-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi

On Wed, Sep 30, 2015 at 11:10 AM, Mark Brown <broonie@kernel.org> wrote:
> I don't think that's true, the expectation is that a left/right sample
> pair is time aligned so the left channel is definitely the start of
> frame for all meaningful purposes.  It's certainly what I'd expect most
> people to understand - choosing a counterintuitive definition to make
> this one statement convenient is going to lead to constant confusion for
> the mode which is clearest.

To clarify, you propose following definition of normal FSYNC polarity:
 - for I2S/left/right justified - frame starts with falling FSYNC edge
 - for DSP A/B - frame starts with rising edge of FSYNC edge (plus offset)
 - for AC97 my guess it is the same as DSP - frame starts with rising
FSYNC edge.

Is it correct?
