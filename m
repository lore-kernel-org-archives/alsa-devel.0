From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sun, 24 Oct 2010 19:49:48 +0800
Message-ID: <AANLkTin3JF9r_i-p6hrB9n+6jb=iPwB5TgP9LFpcb37B@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<AANLkTikajDQp7rLk4ZXp60ebOBhUG3opVH+Mm6a203iC@mail.gmail.com>
	<i9um95$r0q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EE0810384C
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Oct 2010 13:49:49 +0200 (CEST)
Received: by eyg24 with SMTP id 24so1081563eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2010 04:49:49 -0700 (PDT)
In-Reply-To: <i9um95$r0q$1@dough.gmane.org>
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

2010/10/23 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 23/10/10 12:51 did gyre and gimble:
> > Is this the reason why kmix remove the left/right balance control ?
>
> Not sure what you mean by this... kmix can still control left and right
> independently... just right click and chose "split channels".... but
> perhaps I've misinterpreted what you are saying.
>
> Col
>
>
Not sure that your case are similar to the issue described in table 2 of
stac9200 errata and known issues since alsamixertest use a mono sine wave
with sample rate 48000Hz the recorded signal is also mono through plughw, so
it is unlikely for alsamixertest to know whether there is a phase shift in
the left channel

There is a change in DAC sample rates since PA use 44100Hz to probe your
codec and alsamixertest use 48000Hz to play the sine wav

Changes in the DAC sample rates between 44.1 kHz multiples and 48 kHz
multiples can cause attenuation and phase shift in the left channel of the
DAC

S/W workaround exists, but doesn't provide 100% coverage.
The only totally effective method is to lock the sample rate to a given
value.
