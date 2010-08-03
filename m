From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for AK4555 codec
Date: Tue, 3 Aug 2010 16:05:19 +0100
Message-ID: <20100803150519.GG25306@rakim.wolfsonmicro.main>
References: <AANLkTimnYLEe-sK2_DcYQAGqVYd+JnsJaSpRfdKBbeEi@mail.gmail.com>
	<20100729184233.GA9469@sirena.org.uk>
	<AANLkTinWJT36u99_vxOqXOADRNBT9VMy_5mOsBLE1PLO@mail.gmail.com>
	<33CE47F6-34E9-4E47-A8F6-C1091C1708D2@opensource.wolfsonmicro.com>
	<AANLkTin+ZNJD4dizxwK3=ocw3d0YUxZhnX8SkFhVjt9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49A17244D9
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 17:05:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin+ZNJD4dizxwK3=ocw3d0YUxZhnX8SkFhVjt9a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yoran Brondsema <yoran.brondsema@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 30, 2010 at 10:00:12AM +0200, Yoran Brondsema wrote:

> I checked the speaker-test code, and this happens after a call to
> snd_pcm_writei(). The error code is -5, which corresponds to -EIO. In the
> snd_pcm_writei() definition, the following code fails.

> However, in the init function of the codec driver
> (linux/sound/soc/codecs/ak4555.c), I do

Any of the drivers involved in the audio stream can generate an error,
you need to make sure all of them are happy.

> What could be wrong?

You'll need to debug this.  Check how the core expects the stream to be
marked as configured and diagnose why that's not happening.
