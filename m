From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: [PATCH V2 2/3] ARM: bcm2835: I2S: use new
	register-range and clock framework
Date: Sat, 16 Jan 2016 17:47:50 +0100
Message-ID: <25D01EDB-5DD2-4604-B42E-97BB1D186EBD@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
 <569A6134.6070504@lategoodbye.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cgate.sperl.org (212-186-180-163.dynamic.surfer.at
 [212.186.180.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D98A2604D3
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 17:47:48 +0100 (CET)
In-Reply-To: <569A6134.6070504@lategoodbye.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Wahren <info@lategoodbye.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Mike Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>, Takashi Iwai <tiwai@suse.com>, Eric Anholt <eric@anholt.net>, Remi Pommarel <repk@triplefau.lt>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


> On 16.01.2016, at 16:26, Stefan Wahren <info@lategoodbye.de> wrote:
> =

> Hi Martin,
> =

> [add Mike and Remi]
> =

> Am 12.01.2016 um 13:35 schrieb kernel@martin.sperl.org:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> =

>> Since the move to the new clock framework with commit 94cb7f76caa0
>> ("ARM: bcm2835: Switch to using the new clock driver support.")
>> the bcm2835-i2s driver was no longer working.
>> =

>> This patch fixes the address ranges:
>> * remove the PCM clock register range that is owned by the clockmanager
>> * fix the length, which did not include the last register of this device
>> =

>> It also adds the required pcm-clock.
>> =

>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>>  arch/arm/boot/dts/bcm2835.dtsi |    5 ++---
> =

> this won't apply, because the file has been renamed to bcm283x.dtsi.

Well - this "rename=94 was and still is not merged upstream, so it is an
unfortunate circumstance as I am going on vacation and can not create a
new patchset until I return. So please take it as a template
when applying it.

> =

>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> =

>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.=
dtsi
>> index aef64de..83d9787 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -120,9 +120,8 @@
>> =

>>  		i2s: i2s@7e203000 {
>>  			compatible =3D "brcm,bcm2835-i2s";
>> -			reg =3D <0x7e203000 0x20>,
>> -			      <0x7e101098 0x02>;
>> -
>> +			reg =3D <0x7e203000 0x24>;
>> +			clocks =3D <&clocks BCM2835_CLOCK_PCM>;
> =

> After applying clk series ([PATCH V4 0/7] clk: bcm2835: add clocks and ad=
d MASH support) and this series the pcm clock is an orphan.
> =

> Do we need to add "assigned-clocks" to the i2s node just like for pwm [1]?

In my experience it is not needed for PCM, as the clock is set by the
bcm2835-i2s driver, so I left it out.

As I do not know how the orphan PWM clock would be used I can not comment
if this is really needed with PWM or not - it would just set the default
clock if it got referenced in the DT.

Thanks,
	Martin
