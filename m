From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 17:13:07 +0100
Message-ID: <20110914161306.GA22952@sirena.org.uk>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B3C05243F7
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 18:13:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Crowe <drmikecrowe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2011 at 09:37:59AM -0400, Mike Crowe wrote:

> Apologies if this is obvious, but how does the OSS emulation layer set
> hardware parameters at the codec level?

It calls hw_params() repeatedly.

> We are working in an embedded environment, and using a custom codec
> driver.  When we access it via the ALSA API, it works fine.  We have a
> bf5xx_wm8990_hw_params() function with configures the critical

Hrm.  The WM8990 has been supported in mainline for a considerable time,
unless you're using an exceptionally old kernel you really use the
driver.

> When my OSS application opens it's device and changes the audio rate,
> I don't see that function getting called.  In core/oss/pcm_oss.c, I
> see the snd_pcm_oss_set_rate() function getting called, but I don't
> understand how it changes parameters in the codec.  My
> bf5xx_wm8990_hw_params() never gets called.

It should go through the ASoC core; it's possible that you've not
hooked things up properly there.
