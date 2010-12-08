From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Help wanted: emachines em350 internal mic
Date: Wed, 8 Dec 2010 15:12:52 +0800
Message-ID: <AANLkTi=SzY3QP2P+rLrSuhfO7L5CRi-YuR-=Bpk2LRDT@mail.gmail.com>
References: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
	<4CFDA5FF.6060403@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 589C5103820
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 08:12:56 +0100 (CET)
Received: by eyg24 with SMTP id 24so569608eyg.24
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 23:12:54 -0800 (PST)
In-Reply-To: <4CFDA5FF.6060403@audioscience.com>
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

2010/12/7 Eliot Blennerhassett <linux@audioscience.com>

> Thanks Raymond,
>
> On 03/12/10 15:33, Raymond Yau wrote:
> >>> Greetings,
> >
> >
> >>> There is only a single mic on this netbook. However, the alsa device
> >>> shows up as stereo, and the right channel carries an inverted copy of
> >>> the left channel.
> >
> >
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=59c774ed5ee00e9623a204c3234191d6a6d8cf7a
>
> Commitlog was "Add route_policy copy to HDA-Intel.conf for capture
> Since some digital mics have the phase-inversion problem in one channel,
> adding both channels for mono stream results in the noise. Use
> route_policy copy to avoid that situation."
>
> As far as I can guess, the commit helps when an application asks to
> record mono from the stereo device, by copying L rather than summing L+R
>
> My machine already has this, however it doesn't really fix the root of
> the problem.
>
> Because the internal mic appears as a stereo device, rather than a mono,
> applications can open it as stereo.
>
> Only later when the resulting signal L+R is sent to a mono output does
> the signal "disappear".
>
> So I'm back to wondering how to force an app (primarily PulseAudio) to
> see the mic as mono?
>

The easy way is to mute one of the channel using capture switch while you
recording and the result signal will be L/2 or R/2

Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [30.00dB] [on]
  Front Right: Capture 31 [100%] [30.00dB] [on]
