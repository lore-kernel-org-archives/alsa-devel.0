From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: dsp after dmix
Date: Wed, 16 Oct 2013 17:31:33 +0200
Message-ID: <CAOf5uwnw4N1BogGpARwjMm3Kc2HO=A9c48xAWhTF721eHCuRtg@mail.gmail.com>
References: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
 <525B985A.30409@ladisch.de>
 <CAOf5uwnFtN4mDqgfLThRXGUcHQpFJ6wkFFoZhBJdWc6FaBPapg@mail.gmail.com>
 <525BE047.9000501@ladisch.de>
 <CAOf5uwne9V3FgB_3rhTDr0Z08wJYKGAP8M1pR0VYhXxZ4rio-g@mail.gmail.com>
 <20131014203309.GR2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F68226036C
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 17:31:33 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id h11so974072wiv.16
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 08:31:33 -0700 (PDT)
In-Reply-To: <20131014203309.GR2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Mon, Oct 14, 2013 at 10:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 14, 2013 at 02:18:27PM +0200, Michael Trimarchi wrote:
>
>> > You would have to write an ALSA kernel driver for the DSP device.
>
>> This is not a good approach of the general problem because a lot of
>> dsp has userspace
>> support and firmware and initialization is done by userspace library.
>> Can I change
>> the writei and readi of the dmix plugin and let use my dsp function?
>
> I'm not sure that's generally common - memory to memory DSPs are a bit
> unusual for audio since the latency requirements tend to be fairly
> tight.  I can't think of many examples that don't need some exposure to
> the kernel...

A lot of time you need to deal with SDK from others so in my case the dsp
can be used only from the userspace. If the applicaiton does not do the
audio mixing and the dmix is optimized to use the mmap and shared
memory region the only way is to use somenthing like the aloop but
this will increase the overhead like using pulseaudio.

Michael
