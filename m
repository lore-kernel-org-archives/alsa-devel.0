From: nerwusek <luk0104@gmail.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Tue, 07 Aug 2012 23:48:24 +0200
Message-ID: <50218D28.1080404@gmail.com>
References: <50216A11.3050407@gmail.com>
 <20120807192645.GD14711@sirena.org.uk> <50216F4E.1040201@gmail.com>
 <CA+E=qVeeOhXB7iF_BFEp0FpguJQaUhV2nz_0HR4vxnwsMVXJ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A7536265F59
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 23:19:05 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so27707bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 14:48:51 -0700 (PDT)
In-Reply-To: <CA+E=qVeeOhXB7iF_BFEp0FpguJQaUhV2nz_0HR4vxnwsMVXJ6Q@mail.gmail.com>
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

On 07.08.2012 23:18, Vasily Khoruzhick wrote:
> Maybe some amplifier is not enabled? On iPAQ h1940 and rx1950 you need to
> toggle gpio pin to hear something from internal speaker (not sure if
> that pin disables
> headphones).
When I change volume of Analog Mixer the noise in headphones is
getting stronger or weaker so GPIOs in my opinion are set up correctly.

I'll enable debug messages on i2s bus and see if there is sth
sent to codec. Maybe alsa is sending music packets to /dev/null.

I will also want to see what debugfs files should contain when audio works.
Could you send me few examples or point me to address with them?

=A3ukasz Da=B3ek
