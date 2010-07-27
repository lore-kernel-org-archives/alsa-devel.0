From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 10:20:20 -0500
Message-ID: <AANLkTikGhu8EVLozlBWmC6Tuu_gHZX_mkTRImsMo91TE@mail.gmail.com>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<1280238546.3085.89.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id B9124245D9
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 17:20:51 +0200 (CEST)
Received: by qwi2 with SMTP id 2so827189qwi.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 08:20:50 -0700 (PDT)
In-Reply-To: <1280238546.3085.89.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 27, 2010 at 8:49 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> Each machine DAI link now has a sysfs entry so we can inspect its
> configuration/status now.

I have a suspicion that this will totally break my code.

> Hence each machine DAI link must be named
> differently. You could have a "cs4270 playback" and "cs4270 capture" DAI
> links now.

That won't work either.  For one thing, the CS4270 driver registers
only one DAI, and it's called "cs4270-hifi".  So I have to call it
"cs4270-hifi".  So I can't call it anything else.

ASoC should detect when the machine driver is registering a connection
between a CPU object and a codec, if the codec's DAI has already been
given a sysfs entry.

-- 
Timur Tabi
Linux kernel developer at Freescale
