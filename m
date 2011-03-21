From: Tanu Kaskinen <tanu.kaskinen@digia.com>
Subject: Re: Question
	about	snd_mixer_selem_get_playback_dB_range()
Date: Mon, 21 Mar 2011 15:55:22 +0200
Message-ID: <1300715722.24854.290.camel@IT-W2076>
References: <1300711933.24854.263.camel@IT-W2076>
	<AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.digia.com (smtp1.digia.com [82.118.214.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CB7E243F9
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 14:55:26 +0100 (CET)
Received: from smtp1.digia.com (unknown [127.0.0.1])
	by IMSVA80 (Postfix) with ESMTP id 50C073700B3
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 15:55:23 +0200 (EET)
Received: from IT-EXCH02-HKI.it.local (unknown [10.9.52.53])
	by smtp1.digia.com (Postfix) with ESMTP id 410463700B1
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 15:55:23 +0200 (EET)
In-Reply-To: <AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>
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

On Mon, 2011-03-21 at 15:43 +0200, Raymond Yau wrote:
> 2011/3/21 Tanu Kaskinen <tanu.kaskinen@digia.com>
> 
> > Hi,
> >
> > I have added code to Pulseaudio that checks that the kernel driver
> > returns the same values if I call
> > snd_mixer_selem_get_playback_dB_range() or
> > snd_mixer_selem_ask_playback_vol_dB() with the lowest and highest volume
> > steps. The reason I do this is that I've seen a driver that didn't
> > return correct values from _dB_range() (it's fixed nowadays), so it's
> > possible that the same kind of bugs will be seen in the future too.
> > Doing this check at Pulseaudio startup helps to detect such bugs early.
> >
> > My question is about the case where the lowest volume step is mute. Is
> > it a bug in the driver if _dB_range() returns something else than
> > SND_CTL_TLV_DB_GAIN_MUTE as the min gain in such case?
> >
> >
> AFAIK , only those STAC920x codec has SND_CTL_TLV_DB_GAIN_MUTE

Also some broken HDA cards, but I'm not referring to any particular
driver. I just want to get my code right.

> most driver does not has min dB mute as the alsa driver just use the values
> in the datasheet of most codec and DAC
> 
> So it is not any driver bug

What is not any driver bug?

> I guess why the volume slider of gnome volume control is mute at mint is
> just follow the behaviour of those OSS driver

Thank you for your reply. Unfortunately, I'm not much wiser after
reading it.

I'll repeat my question:

Is it a bug in alsa (the driver or alsa-lib or whatever) if
snd_mixer_selem_get_playback_dB_range() returns something else than
SND_CTL_TLV_DB_GAIN_MUTE as the min gain, if the lowest volume step for
the element is mute?

-- 
Tanu
