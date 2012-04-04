From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: UHCI dropped audio samples / DMA starvation fix
Date: Wed, 4 Apr 2012 17:35:30 -0400
Message-ID: <CACrD=+8DUJ3kb6nSbTqc1RFDg5CQL=1FzdVd=pOm+4cpisvh9Q@mail.gmail.com>
References: <CACrD=+9OSMrf1ghQdvQ7xP7gpXUvT2jkgNh+1qQ5Efem7wsZaA@mail.gmail.com>
	<4F7CB50A.5090701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2B2CF2475A
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 23:35:32 +0200 (CEST)
Received: by laap9 with SMTP id p9so856045laa.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Apr 2012 14:35:30 -0700 (PDT)
In-Reply-To: <4F7CB50A.5090701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Responding to the rest inline, but unfortunately the point is moot;
after two days of running well in production and believing it fixed,
one of my boxes is once again starving UHCI DMA even with the patch.
So I did not in fact fix it.

> I've heard that the latest Intel architecture allows DMA to and from(?)
> the L3 cache.

FTR, the machines I'm testing on are Core Duo, Core2 Duo and first-gen Neha=
lem.

> | The Host Controller fetches the next entry from the Frame List when
> | the millisecond allotted to the current frame expires.
>
> ... so it is not actually possible to prefetch packets in a useful way.

That was my conclusion as well.  I could find no hooks to do so.  it also s=
ays:

|Host Controller fetches and decodes the Transfer Descriptor. Assuming
a Host-to-Function transaction, the
|Host Controller delays committing to the USB Transaction until the
FIFO fills to an appropriate =93trigger point=94.
|When this threshold is reached, the Host Controller can then begin
issuing the Transaction Token.

>> Unfortunately, the URB abstraction gives us no reliable way to do it
>> in the HCD, because other drivers don't necessarily pass a valid
>> CPU-side buffer address when using URB_NO_TRANSFER_DMA_MAP.
>
> But the USB API requires this (any HCD might use PIO or use its own
> double-buffering scheme).

Oh, it does?  I hadn't been able to come to that conclusion from the
docs I read.  If so, then that's good.

Anyway, going to keep trying.

Monty
