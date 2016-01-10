From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM
	clock
Date: Sun, 10 Jan 2016 10:30:33 +0100
Message-ID: <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 67F82260459
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 10:30:36 +0100 (CET)
Received: by mail-io0-f194.google.com with SMTP id f81so8436469iof.0
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 01:30:36 -0800 (PST)
In-Reply-To: <4332640.jBKM55TPAo@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, lFlorian Meier <florian.meier@koalo.de>, Michael Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>, Takashi Iwai <tiwai@suse.com>, Eric Anholt <eric@anholt.net>, Remi Pommarel <repk@triplefau.lt>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, Martin Sperl <kernel@martin.sperl.org>, Matthias Reichl <hias@horus.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On Sat, Jan 9, 2016 at 9:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 09 January 2016 09:25:54 kernel@martin.sperl.org wrote:
>> --- a/include/dt-bindings/clock/bcm2835.h
>> +++ b/include/dt-bindings/clock/bcm2835.h
>> @@ -44,5 +44,6 @@
>>  #define BCM2835_CLOCK_EMMC             28
>>  #define BCM2835_CLOCK_PERI_IMAGE       29
>>  #define BCM2835_CLOCK_PWM              30
>> +#define BCM2835_CLOCK_PCM              31
>>
>> -#define BCM2835_CLOCK_COUNT            31
>> +#define BCM2835_CLOCK_COUNT            32
>
> The last line contains an incompatible change, please don't do that.
> If you have to add another clock, do that after the BCM2835_CLOCK_COUNT
> definition to avoid changing dts files that use that number.

While I agree this changes dts files (in an unexpected way?), not updating
BCM2835_CLOCK_COUNT makes it definition useless. Which teaches that
having such definitions in DT headers is not a good idea in the first place...

Hence it can better be replaced (it seems to be unused in dts files, but you
can keep the definition to be 100% sure) by an ARRAY_SIZE() in the C driver.
This requires changing the driver to e.g. initialize clks[] in
bcm2835_clk_probe() based on a table instead of explicit code.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
