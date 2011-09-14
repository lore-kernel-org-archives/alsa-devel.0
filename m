From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 12:27:05 -0400
Message-ID: <CA+jNppnR+J58vp-7Q0Nd6DY4-Y1gfzZ6kCfCNE1WCGdddROzQg@mail.gmail.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<20110914161306.GA22952@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id 04FEB243F8
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 18:27:27 +0200 (CEST)
Received: by yie16 with SMTP id 16so1276954yie.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:27:27 -0700 (PDT)
Received: by ywa17 with SMTP id 17so1623717ywa.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:27:25 -0700 (PDT)
In-Reply-To: <20110914161306.GA22952@sirena.org.uk>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

On Wed, Sep 14, 2011 at 12:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> It calls hw_params() repeatedly.

I have debug statements in core/oss/pcm_oss.c and in
soc/codecs/wm8990.c.  When I use ALSA to play a sound, I see the
wm8990 debug statements.  However, when the OSS application changes
the rate in snd_pcm_oss_set_rate(), I never see the wm8990 debug
statements for the different rate.

>
> Hrm. =A0The WM8990 has been supported in mainline for a considerable time,
> unless you're using an exceptionally old kernel you really use the
> driver.
>

This is using the wm8990 driver, but with a custom hardware interface
(so we did have to write custom I2S drivers to get to the codec).

> It should go through the ASoC core; it's possible that you've not
> hooked things up properly there.
>

Very possible.  Based on Sean's reply, I may want to disable OSS
emulation and look at a userspace solution.

Mike
