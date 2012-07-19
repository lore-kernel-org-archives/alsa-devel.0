From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Selecting Audio formats
Date: Thu, 19 Jul 2012 17:00:03 +0200
Message-ID: <500820F3.4050302@ladisch.de>
References: <CAA4JwzUwL=nkwcpJa62i9nLW8MOZ3mcj696-53V3R-wbdkbnnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CDE5C2652D1
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 17:00:02 +0200 (CEST)
In-Reply-To: <CAA4JwzUwL=nkwcpJa62i9nLW8MOZ3mcj696-53V3R-wbdkbnnA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harman Kalra <harman4linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Harman Kalra wrote:
> Since so many PCM formats such as S8, U8, S16_LE, U16_LE, A-law, u-law-,
> IMA_ADPCM, MPEG, GSM, etc are there so which format should I opt for.

In most cases, you should use some format supported by your hardware.
Typically, this is S16.

>    1.  What is difference between signed and unsigned PCM format, how does
>    it can affect the sound quality.

It does not affect the sound quality.

>    2. If I go for MPEG format, does it mean that audio compression would
>    handled at my audio port level and my DSP processor would not come into
>    picture.

If you tried to set MPEG format, ALSA would inform you that the device
does not support this.

>    4. If I opt for A-law or u-law, what could be benefits/disadvantages of
>    using these formats.

These formats use one byte per sample, like U8, but have more dynamic
range than U8.  They are still worse than S16.


Regards,
Clemens
