From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Question about
	snd_mixer_selem_get_playback_dB_range()
Date: Mon, 21 Mar 2011 21:43:03 +0800
Message-ID: <AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>
References: <1300711933.24854.263.camel@IT-W2076>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1FEB3243E7
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 14:43:14 +0100 (CET)
Received: by fxm6 with SMTP id 6so5292550fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 06:43:13 -0700 (PDT)
In-Reply-To: <1300711933.24854.263.camel@IT-W2076>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/21 Tanu Kaskinen <tanu.kaskinen@digia.com>

> Hi,
>
> I have added code to Pulseaudio that checks that the kernel driver
> returns the same values if I call
> snd_mixer_selem_get_playback_dB_range() or
> snd_mixer_selem_ask_playback_vol_dB() with the lowest and highest volume
> steps. The reason I do this is that I've seen a driver that didn't
> return correct values from _dB_range() (it's fixed nowadays), so it's
> possible that the same kind of bugs will be seen in the future too.
> Doing this check at Pulseaudio startup helps to detect such bugs early.
>
> My question is about the case where the lowest volume step is mute. Is
> it a bug in the driver if _dB_range() returns something else than
> SND_CTL_TLV_DB_GAIN_MUTE as the min gain in such case?
>
>
AFAIK , only those STAC920x codec has SND_CTL_TLV_DB_GAIN_MUTE

most driver does not has min dB mute as the alsa driver just use the values
in the datasheet of most codec and DAC

So it is not any driver bug

I guess why the volume slider of gnome volume control is mute at mint is
just follow the behaviour of those OSS driver
