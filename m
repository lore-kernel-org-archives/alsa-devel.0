From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v3] sound/soc/lapis: add platform driver
	for ML7213
Date: Fri, 9 Mar 2012 15:26:27 +0900
Message-ID: <CANKRQngo_Wz-5XqdYe9TWe2QhmVgUTZc3TRajFT+CLjvEAWVdA@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-2-git-send-email-tomoya.rohm@gmail.com>
	<20120302163915.GD6056@opensource.wolfsonmicro.com>
	<CANKRQni8hPoHEsV2VecbgKBdfS5+rit0-jXzz_d8F_nY5-dN3g@mail.gmail.com>
	<20120306115246.GD19635@opensource.wolfsonmicro.com>
	<CANKRQngg+8LJvb-+Byv6XPqqWFyCU1U+-hppuxo_=CM1qLUF_Q@mail.gmail.com>
	<20120307114631.GE3107@opensource.wolfsonmicro.com>
	<CANKRQnh2x-EYyaiOaz58zBeAe7PKWNS6cE+yyha5jSvignigHw@mail.gmail.com>
	<20120308110548.GG3638@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26D2E104239
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 07:26:28 +0100 (CET)
Received: by pbcwy12 with SMTP id wy12so2802054pbc.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 22:26:27 -0800 (PST)
In-Reply-To: <20120308110548.GG3638@opensource.wolfsonmicro.com>
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

On Thu, Mar 8, 2012 at 8:05 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> > You've still not explained the problem you're seeing but this sounds
>> > like something that should work. =A0Please address the
>> * Faced problem if there are no platform settings.
>> machine driver's hw_params is not called
>> platform_driver's functions(snd_pcm_ops, snd_soc_platform_driver) are
>> not called.
>> As a result, the following message is not showed . (by soc_pcm.c)
>> printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
>> =A0 =A0 =A0 =A0 =A0cpu_dai->name);
> This makes no sense. =A0Registering a platform device will have *no*
> impact on ASoC, it only cares if the relevant ASoC function drivers have
> come up. =A0Probably there was some other problem with what you were doing
> but it's hard to say...

I've confirmed that driver detected by ASoC correctly without these
platform functions.
Please check next patch series.

thanks.
-- =

ROHM Co., Ltd.
tomoya
