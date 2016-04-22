From: Petr Kulhavy <petr@barix.com>
Subject: Re: [PATCH v3 1/7] ASoC: davinci-mcbsp: add binding
	for McBSP
Date: Fri, 22 Apr 2016 10:33:31 +0200
Message-ID: <5719E1DB.5040703@barix.com>
References: <1460982766-18632-1-git-send-email-petr@barix.com>
 <1460982766-18632-2-git-send-email-petr@barix.com>
 <CAMuHMdVCW0zAxAZRTazVhXz72fkp_escQM2JTSX2J4Ertru==Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id BB06D261A76
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 10:33:34 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id n3so15207028wmn.0
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 01:33:34 -0700 (PDT)
In-Reply-To: <CAMuHMdVCW0zAxAZRTazVhXz72fkp_escQM2JTSX2J4Ertru==Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pawel Moll <pawel.moll@arm.com>, Kevin Hilman <khilman@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 20.04.2016 08:49, Geert Uytterhoeven wrote:
> On Mon, Apr 18, 2016 at 2:32 PM, Petr Kulhavy <petr@barix.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>> @@ -0,0 +1,51 @@
>> +Optional properties:
>> +~~~~~~~~~~~~~~~~~~~~
>> +- interrupts : Interrupt numbers for McBSP
>> +- interrupt-names : Known interrupt names are "rx" and "tx"
>> +
>> +- pinctrl-0: Should specify pin control group used for this controller.
>> +- pinctrl-names: Should contain only one value - "default", for more details
>> +        please refer to pinctrl-bindings.txt
>> +
>> +Example (AM1808):
>> +~~~~~~~~~~~~~~~~~
>> +
>> +mcbsp0: mcbsp@1d10000 {
>> +       compatible = "ti,da850-mcbsp";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mcbsp0_pins>;
>> +
>> +       reg =   <0x00110000 0x1000>,
>> +               <0x00310000 0x1000>;
>> +       reg-names = "mpu", "dat";
>> +       interrupts = <97 98>;
>> +       interrupts-names = "rx", "tx";
> interrupt-names
Good catch, thanks!

Petr
