From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v3] sound/soc/lapis: add platform driver
	for ML7213
Date: Thu, 8 Mar 2012 11:06:47 +0900
Message-ID: <CANKRQnh2x-EYyaiOaz58zBeAe7PKWNS6cE+yyha5jSvignigHw@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-2-git-send-email-tomoya.rohm@gmail.com>
	<20120302163915.GD6056@opensource.wolfsonmicro.com>
	<CANKRQni8hPoHEsV2VecbgKBdfS5+rit0-jXzz_d8F_nY5-dN3g@mail.gmail.com>
	<20120306115246.GD19635@opensource.wolfsonmicro.com>
	<CANKRQngg+8LJvb-+Byv6XPqqWFyCU1U+-hppuxo_=CM1qLUF_Q@mail.gmail.com>
	<20120307114631.GE3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE468104130
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 03:06:48 +0100 (CET)
Received: by pbcwy12 with SMTP id wy12so1333939pbc.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 18:06:47 -0800 (PST)
In-Reply-To: <20120307114631.GE3107@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 7, 2012 at 8:46 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> >> if these platform devices aren't used, device detection doesn't work =
correctly.
>> >> So, I added these.
>> > You've not actually mentioned the problem you were seeing...
>> I saw mapping problem between machine driver and platform driver.
>> e.g. =A0cpu_dai_name "ml7213ioh"
> You've still not explained the problem you're seeing but this sounds
> like something that should work. =A0Please address the

* Faced problem if there are no platform settings.
machine driver's hw_params is not called
platform_driver's functions(snd_pcm_ops, snd_soc_platform_driver) are
not called.

As a result, the following message is not showed . (by soc_pcm.c)
printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
         cpu_dai->name);

>> > Apart from anything else you've got the interrupt requested as
>> > IRQF_SHARED so the interrupt could get called at any time. =A0It's also
>> > not clear that you've got the hardware in a known good state.
>> Do you mean request_irq should move to somewhere, like open() or
>> hw_params() or ... ?
> You need to do enough hardware and software initialisation prior to
> requesting the interrupt to ensure that if an interrupt does happen it
> won't cause any ill effects. =A0Checks in the interrupt handler to make
> sure things like the ALSA layer stuff have been set up can also be used
> to make the interrupt handler safer.

I can understand your concern.
Let me clarify your think.
You think that interrupt handler must check whether ALSA initialization has
already finished or not before interrupt process executes.
Right?

thanks.
-- =

ROHM Co., Ltd.
tomoya
