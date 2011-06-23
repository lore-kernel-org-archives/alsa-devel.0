From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA - HDA - Add period time constraint to
	hda-intel
Date: Thu, 23 Jun 2011 09:14:57 +0800
Message-ID: <BANLkTin_oEtObPi5n1JFJrs_V25eu7_1OQ@mail.gmail.com>
References: <BANLkTimy_SFEFfTx55wFNdQmNPbDiguFdg@mail.gmail.com>
	<s5hlixw4ol3.wl%tiwai@suse.de>
	<BANLkTim2oO6JnFQre97U6PdaFe6C91AeXg@mail.gmail.com>
	<s5hboyq2dib.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B52082455A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 03:14:57 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1106681fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 18:14:57 -0700 (PDT)
In-Reply-To: <s5hboyq2dib.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/26 Takashi Iwai <tiwai@suse.de>:
> At Thu, 26 May 2011 10:01:14 +0800,
>
> Yeah, this was overlooked. =A0The patch below fixes both issues.
> Also it checks no_period_wakeup flag just to be sure (although setting
> this for normal read/write/drain operations doesn't make sense).
>
>

Since aplay does not support no period wakeup mode

I can only confirm that your patch fix the read/write and drain when
aplay using maximum period size/time of HDA codec (e.g. 11 seconds
period time for 44100Hz when prealloc is 4096)

Not sure whether  pulseaudio server still use maximum buffer size or not

but in pulsecore/sink.c and pulsecore/source.c

#define ABSOLUTE_MIN_LATENCY (500)
#define ABSOLUTE_MAX_LATENCY (10*PA_USEC_PER_SEC)
#define DEFAULT_FIXED_LATENCY (250*PA_USEC_PER_MSEC)

CPU usage jump from 2% to 12% when using

aplay -Dpulse --period-time=3D500 --buffer-time=3D1500 /usr/share/sounds/al=
sa/*.wav

although the sound is still good but PA server generate a huge amount
of messages
