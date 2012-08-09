From: nerwusek <luk0104@gmail.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Thu, 09 Aug 2012 18:43:45 +0200
Message-ID: <5023E8C1.4020302@gmail.com>
References: <50216A11.3050407@gmail.com>
 <20120807192645.GD14711@sirena.org.uk> <50216F4E.1040201@gmail.com>
 <CA+E=qVeeOhXB7iF_BFEp0FpguJQaUhV2nz_0HR4vxnwsMVXJ6Q@mail.gmail.com>
 <50218D28.1080404@gmail.com> <20120808095747.GF14711@sirena.org.uk>
 <50224AA4.4010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C52562663E1
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 18:14:33 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so231767bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 09:44:19 -0700 (PDT)
In-Reply-To: <50224AA4.4010902@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08.08.2012 13:16, nerwusek wrote:
> On 08.08.2012 11:57, Mark Brown wrote:
>> This sounds like either the CPU isn't actually sending data or =

>> there's a digital mute. =

> Debugfs file asoc/ipaq/uda.../dapm/Playback shows:
> Playback: On  in 1 out 1
>  stream Playback active
>  out "static" "DAC"
>  out "static" "DAC"
>  out "static" "DAC"
>
> and file DAC shows:
> DAC: On  in 3 out 4 - R2(0x2) bit 10
>  stream Playback inactive
>  in  "static" "Playback"
>  in  "static" "Playback"
>  in  "static" "Playback"
>  out "DAC" "Output Mux"
>  out "static" "Analog Mixer"
>
> is it correct? Shouldn't stream Playback in DAC show active status?
> Also I noticed that alsamixer works slower when playing music so
> some data must be sent to codec but I don't know is that music
> data or sth else.
>
> =A3ukasz Da=B3ek
I also booted handhelds kernel (2.6.21) and compared UDA registers with it.
Everything was the same except in my kernel (3.4) was silence.
At this point I have no idea where is the problem.

=A3ukasz Da=B3ek
