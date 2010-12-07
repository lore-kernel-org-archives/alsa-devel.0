From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Bug in alsa drivers reported when launching
	pulseaudio
Date: Tue, 7 Dec 2010 08:11:49 -0600
Message-ID: <AANLkTinVfotXUxoZQxaqPvMn0M5gcc0FhWASDHob0JL=@mail.gmail.com>
References: <AANLkTi=Oeek9Di8bbck=245YYa=YLxfO9pMWmOXb-og4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF504103AA9
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:11:50 +0100 (CET)
Received: by iwn41 with SMTP id 41so1309343iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 06:11:50 -0800 (PST)
In-Reply-To: <AANLkTi=Oeek9Di8bbck=245YYa=YLxfO9pMWmOXb-og4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kieran magee <kiergbm@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 4, 2010 at 12:54 PM, kieran magee <kiergbm@gmail.com> wrote:
> Some strange anomalies were occuring in my audio systems, namely, volume
> fluctuations during playback. =A0Attempted to access sound in preferences=
, had
> disabled pulseaudio a while back with no ill effects, (weeks back), I
> couldn't access the menu Item. =A0I was instructed that pulseaudio not ru=
nning
> may be the issue, so attempted to launch that and came upon this worrying
> error message,
>
> E: alsa-util.c: snd_pcm_avail_delay() returned strange values: delay 0 is
> less than avail 16.
> E: alsa-util.c: Most likely this is a bug in the ALSA driver
> 'snd_hda_intel'. Please report this issue to the ALSA developers.


This error was fixed in alsa-lib.
http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dcommit;h=3Daba87e509898ec=
9ddb3e319267d7c267409ff100
It has nothing to do with your volume control issues.
-Pierre
