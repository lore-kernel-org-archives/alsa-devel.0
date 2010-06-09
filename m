From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Wed, 9 Jun 2010 14:19:40 +0800
Message-ID: <AANLkTin4QkV2MFRhj60cJOIFArKlbr2FhqQsk-Fn63Zf@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimQtKql4p3UEs2Wh_tZ6YhzLGgl1q5G18A1y9Jk@mail.gmail.com>
	<AANLkTilKqn_X3FUdDmCqy3YKdYeT47oIGGaqUitzruDk@mail.gmail.com>
	<201005201141.28755.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<AANLkTikEUdCu4UvSRONmiRXdEWsOo-0882JyvWWuxn4I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f189.google.com (mail-pz0-f189.google.com
	[209.85.222.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B56B10382F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 08:19:42 +0200 (CEST)
Received: by pzk27 with SMTP id 27so360445pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 23:19:40 -0700 (PDT)
In-Reply-To: <AANLkTikEUdCu4UvSRONmiRXdEWsOo-0882JyvWWuxn4I@mail.gmail.com>
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

2010/5/21 James Courtier-Dutton <james.dutton@gmail.com>

> On 21 May 2010 07:35, Clemens Ladisch <clemens@ladisch.de> wrote:
> > James Courtier-Dutton wrote:
> >
> >> For the cards that do have this 32bit linear value, a simple lookup
> >> table is used in the kernel code to convert it to 256 step values.
> >
> > Which driver is this?  It should be changed to use the full range.
> >
>
> All creative and emu cards with a DSP.
> They use a lookup table in the driver.
>

seem a bug in the lookup table of alsa-lib

20log10(1/100) = -40dB , it should return -40dB  if set -40dB

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4883

snd_mixer_selem_set_playback_dB(<master element>, 0, -4000, +1) -> returns 0
snd_mixer_selem_get_playback_dB(<master element>, 0, &value) -> returns 0,
sets value to -9999999
