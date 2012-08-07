From: nerwusek <luk0104@gmail.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Tue, 07 Aug 2012 21:41:02 +0200
Message-ID: <50216F4E.1040201@gmail.com>
References: <50216A11.3050407@gmail.com> <20120807192645.GD14711@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 630A7265FE9
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 21:11:43 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1454147bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 12:41:29 -0700 (PDT)
In-Reply-To: <20120807192645.GD14711@sirena.org.uk>
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

On 07.08.2012 21:26, Mark Brown wrote:
> Have you checked that the output isn't muted, has the audio routed to =

> the output you're using and has a suitable volume? =

Yes I have checked all that things. I have 2 routes from VOUTHP{LR} and =

from VOUT{LR} and I think it's ok because of info in logs "asoc: =

uda1380-hifi <-> pxa2xx-i2s mapping ok".
I have also observed that if I change Output Mux from DAC to Analog =

Mixer and change Anolog Mixer volume up the noise and louder.
In my opinion problem is somewhere else. I think that I forgot to enable =

sth in ALSA. As I said when I enabled I2C debugging data flows only when =

playback is starting or when I change values in alsamixer, when music is =

played no data are send to codec.

=A3ukasz Da=B3ek
