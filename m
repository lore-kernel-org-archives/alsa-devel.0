From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compiler errors in alsa-lib-1.0.22/test/*.c
Date: Wed, 21 Jul 2010 08:58:08 +0200
Message-ID: <4C469A80.4050806@ladisch.de>
References: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>	<4C3C0540.6020506@ladisch.de>	<AANLkTinsZlWl0VtR8F1mHHYUNUd6jHvTjGhd_J2sdsoM@mail.gmail.com>	<AANLkTinuYzw-4iuEyemaL4Jlh0NC0byhPBNJ5nu5tscX@mail.gmail.com>	<AANLkTilDAsnNVSs17ochWuMfBlU_PIbL4OzH67CtPcLD@mail.gmail.com>	<alpine.LNX.2.00.1007191052020.9258@eeebox2.perex-int.cz>	<AANLkTinomEJIjm4DOkZPUcL0d_I6PwzHIGNiT5sUd1FZ@mail.gmail.com>
	<AANLkTimjK6fzRKxtj0fnQ3xPDOyXHAWikq6MZxqy-sj2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2F88124468
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 08:58:13 +0200 (CEST)
In-Reply-To: <AANLkTimjK6fzRKxtj0fnQ3xPDOyXHAWikq6MZxqy-sj2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: john@swajime.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Simpson wrote:
> Playback open error: Inappropriate ioctl for device

Make sure that both your kernel and your alsa-lib use the correct
compiler and compiler flags (where "correct" usually means "whatever
the vendor's distribution uses").

> This time, checking out https://vcs.maemo.org/svn/dsp-alsa

It would be nice to know what the changes from the original alsa-lib
are; in theory, they should go upstream.

> $ cd dsp-alsa/trunk/alsa-lib
> #### cvscompile does not succeed

Why?

> $ .libs/pcm -D 'default' -vf 440
> Playback device is default
> Stream parameters are 44100Hz, S16_LE, 1 channels
> Sine wave rate is 440.0000Hz
> Using transfer method: write
> 
> Still no sound :-(

Mixer controls not set?  (amixer and alsamixer are in alsa-utils)


Regards,
Clemens
