From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Wed, 8 Aug 2012 09:26:31 +0300
Message-ID: <CA+E=qVfCd2wjq5tM3b1c3VJnPKdjP29=jeaFE+TY=cTf3rArVA@mail.gmail.com>
References: <50216A11.3050407@gmail.com> <20120807192645.GD14711@sirena.org.uk>
 <50216F4E.1040201@gmail.com>
 <CA+E=qVeeOhXB7iF_BFEp0FpguJQaUhV2nz_0HR4vxnwsMVXJ6Q@mail.gmail.com>
 <50218D28.1080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 363C9266041
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 07:57:07 +0200 (CEST)
Received: by vbbfn1 with SMTP id fn1so376792vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 23:26:52 -0700 (PDT)
In-Reply-To: <50218D28.1080404@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nerwusek <luk0104@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 8, 2012 at 12:48 AM, nerwusek <luk0104@gmail.com> wrote:
> On 07.08.2012 23:18, Vasily Khoruzhick wrote:
>>
>> Maybe some amplifier is not enabled? On iPAQ h1940 and rx1950 you need to
>> toggle gpio pin to hear something from internal speaker (not sure if
>> that pin disables
>> headphones).
>
> When I change volume of Analog Mixer the noise in headphones is
> getting stronger or weaker so GPIOs in my opinion are set up correctly.
>
> I'll enable debug messages on i2s bus and see if there is sth
> sent to codec. Maybe alsa is sending music packets to /dev/null.
>
> I will also want to see what debugfs files should contain when audio works.
> Could you send me few examples or point me to address with them?

Well, I've no compiled kernel nor rootfs for my PDAs :( and I'll be
pretty busy this weekend,
so it'll take some time to get debugfs contents for you.

Regards
Vasily
