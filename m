From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Fri, 28 Aug 2015 16:23:34 -0700
Message-ID: <CAOMFOmUnntAEF07h6rOxXQTNavBq0L6jNuMEA2j0PsmaE-XGLQ@mail.gmail.com>
References: <20150731182716.GO20873@sirena.org.uk>
 <CAOMFOmVA5HB138TUghe7fRwq4661vvQZt0NU5iJDZhkuGUZH1g@mail.gmail.com>
 <20150804094757.GE20873@sirena.org.uk>
 <CAOMFOmUg2D_T338=zFSrzw=ZRGRw9awLYrKFxhoPmOEd5NGZSA@mail.gmail.com>
 <20150811163954.GM10748@sirena.org.uk>
 <CAOMFOmWTahWyq3Oto2h3bVEwke7=FzGpJ2sG48vqkRrNb_--QA@mail.gmail.com>
 <20150813112639.GB1654@sirena.org.uk>
 <CAOMFOmXm66VgFPfD=NBMJNbqUvE0mbBSq5mRPk_4APuUJPcF_A@mail.gmail.com>
 <20150813223339.GN10748@sirena.org.uk>
 <CAOMFOmVtw9sXBRp6hkNu+AfhQR2TF-uJeyyB0SmHTtgLd8ZoQw@mail.gmail.com>
 <20150817182040.GS10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id C8492265BA3
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 01:23:35 +0200 (CEST)
Received: by vkhf67 with SMTP id f67so16545257vkh.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 16:23:34 -0700 (PDT)
In-Reply-To: <20150817182040.GS10748@sirena.org.uk>
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
Cc: mfelton1@nuvoton.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dylan Reid <dgreid@google.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi

Sorry for the delay.

On Mon, Aug 17, 2015 at 11:20 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Aug 16, 2015 at 12:38:41AM -0700, Anatol Pomozov wrote:
>> On Thu, Aug 13, 2015 at 3:33 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > So ACPI based platforms have to deal with providing clocks in some other
>> > way, that's something that is abstracted away by the clock API.  There
>> > are a number of drivers for both board file based and ACPI based systems
>> > already in tree which manage to make use of the clock API.
>
>> What is the best example of driver that uses clk API in both DT and
>> ACPI friendly way? I will use it as a template for my driver.
>
> Any driver using the clock API should provide a suitable reference.  The
> mechanism used to resolve clocks is completely opaque to the driver
> using the clock API.

Okay, I added clk support for MCLK. set_sysclk() callback sets rate
for this clock. Platform driver needs to call
snd_soc_codec_set_sysclk() to choose codec clock source and set its
rate.

Another change - added 10ms delay after enabling charge pump to eliminate pop.
