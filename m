From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Wed, 24 Jun 2009 11:14:33 -0400
Message-ID: <9e4733910906240814j3dc920dfy6b9c795e7f2339e9@mail.gmail.com>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
	<9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
	<20090623095444.GC5422@sirena.org.uk>
	<9e4733910906240710y2e5bdb21qfbd03af256094c3f@mail.gmail.com>
	<s5hvdml8zmw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FBA310380C
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 17:14:35 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1022954qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 08:14:33 -0700 (PDT)
In-Reply-To: <s5hvdml8zmw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2009 at 10:39 AM, Takashi Iwai<tiwai@suse.de> wrote:
> The glitch-free problem of PA comes from the fact that PA assumes that
> the driver returns the current hw position accurately at any time.
> But, in many hardwares, including HDA, this is not true. =A0The hardware
> lies. =A0It doesn't report the right position at all. =A0Thus, there are
> many workarounds implemented in HD-audio side.

Why does pulse need to know the DMA position?

If it is so that it can write into the buffer with minimal latency
there are other ways to accomplish that. The simplest is to just add
an entry into ALSA core that says, play this buffer with minimal
latency. That would let the transfer be pushed down into the specific
driver and that driver could handle it in an optimal way.

Optimal on my hardware would be to reprogram the DMA hardware to
immediately start playing from the new buffer. No copies involved. The
FIFO will hide the buffer swap from the audio hardware.

Optimal on ring buffer hardware would be to locate where DMA was in
the ring and copy to a position in front of it.

These hardware differences should be hidden from pulse.

-- =

Jon Smirl
jonsmirl@gmail.com
