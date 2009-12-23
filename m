From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: need help with io plugin programming: how to add
	delay ?
Date: Wed, 23 Dec 2009 03:28:15 -0600
Message-ID: <53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
	<4B31D184.3020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F68B103844
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 10:28:16 +0100 (CET)
Received: by iwn2 with SMTP id 2so2028461iwn.16
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 01:28:15 -0800 (PST)
In-Reply-To: <4B31D184.3020300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The simplest solution would probably be completely userspace. Write a jackd
client which connects to the UART, gives itself RT priority using
capabilities, and exposes however many input/output ports as you have.
Google FFADO for an example of the programming model used.

If you need normal apps to drive into it, set up an .asoundrc with a device
using the jack plugin. I still don't see why you need a kernel driver at
all.

On Wed, Dec 23, 2009 at 2:15 AM, Stefan Schoenleitner <
dev.c0debabe@gmail.com> wrote:

> Alex Austin wrote:
> > Do you really need a socket, or are you just trying to move audio data
> > from one app to another? Check out jack and netjack. They may already
> > provide the functionality you need.
>
> I need to move PCM samples to/from alsa from/to a DSP board.
> As the DSP board uses a serial interface (UART) it would be rather
> cumbersome to implement this functionality as kernel driver.
> My solution should be a little bit similar to bluetooth audio as it also
> uses an alsa io plugin and a daemon that actually talks to different
> (hardware-) devices.
>
> cheers,
> stefan
>
