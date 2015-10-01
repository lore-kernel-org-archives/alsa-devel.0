From: Caleb Crome <caleb@crome.org>
Subject: Re: Kernel Device Tree entries for simple-audio-card
Date: Thu, 1 Oct 2015 08:38:53 -0700
Message-ID: <CAG5mAdzmH-eOMo2_prVcMFzsQxXxs667GbVSyNDx9YCiijBYEQ@mail.gmail.com>
References: <4D7C68FE-B884-489C-91DD-395FE7CE181D@latencyzero.com>
 <CAG5mAdxc5-UuTnz24zByA64ZsrB4qnfMKF57GBVeFfWvY44xsw@mail.gmail.com>
 <4D1E67E6-437D-490D-A577-35EB7E474A3A@latencyzero.com>
 <CAG5mAdxnjZUBiOFU6+MBn0znUCBaGpeVQ-RaYhXch=-4n7J4uw@mail.gmail.com>
 <F3A7E580-2E91-45D0-9C27-2FD190110686@latencyzero.com>
 <CAG5mAdxgTzGjnvwno0D_Jo9_53stmGfsc9OQS05f3thrSFKpkw@mail.gmail.com>
 <BE1F1488-2A4D-4EE6-A538-931DD0B34CD8@latencyzero.com>
 <CAG5mAdzg2BSGKiaBJVSgZvL=9wxffxv_3LMiruS2-kcuTKO+xQ@mail.gmail.com>
 <D8BC8B49-E32C-43EE-B181-60510C7B3E8E@latencyzero.com>
 <CAG5mAdxaAapawiaaR_zasVhQKL33MHEHP1yyUCSLv0wswZ9Law@mail.gmail.com>
 <7CCA3F5A-844A-43FF-9A4E-C0A9FB65D926@latencyzero.com>
 <CAG5mAdyOSDt7F5czW_9EBvo3uBCW9834-1VZsXG0mvYiB1LM8g@mail.gmail.com>
 <74203CDA-1965-48ED-AA9A-95DC9A8D83E6@latencyzero.com>
 <532A774B-EA9D-4633-B7B4-4236746B92FE@crome.org>
 <869D210F-8882-4067-8593-18B2BE3197E8@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D0F1F2667CE
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 17:39:15 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so34510791wic.0
 for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2015 08:39:13 -0700 (PDT)
In-Reply-To: <869D210F-8882-4067-8593-18B2BE3197E8@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 29, 2015 at 11:41 AM, Rick Mann <rmann@latencyzero.com> wrote:
> Ugh, sorry. Here you go:
>
> https://github.com/JetForMe/podtique/blob/v1/bbb/cape/Podtique1/BB-ENABLE-PRU.dts
>
> Sent from my iPhone
>
> On Sep 29, 2015, at 07:08, Caleb Crome <caleb@crome.org> wrote:
>
> Now I have a working MCLK, and I see clocking on BCLK and WCLK, but the
> rates are questionable. MCLK is 24 MHz (even though in the DTS it's set to
> 12 MHz); that might be okay.

It's definitely not obvious why you'd be getting 24MHz instead of 12.
Wait.  Are you getting exactly 24 MHz, or about 24 MHz?  in
davinci-evm.c there are some .sysclk settings set to 24576000 as in
the da830_snd_soc_card_crvdata.

>
>
>   # speaker-test -r 22050 -c 2 -f 1000 -F S16_LE -t sine -s 1 -D hw:0,0
>
>
> WCLK is 11.88 kHz, and it is pulses (DSP mode), rather than high for left,
> low for right for each channel's word. BCLK is 379.5 kHz.

Sounds like you're not in I2S mode, you must be in DSP or
left-justified mode.  That's set in your eavinci-evm.c in the
snd_soc_dai_link structure under the field .dai_fmt.  Most of them are
set to SND_SOC_DAIFMT_DSP_B.

-Caleb
