From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: Document the dmas and
 dma-names properties for bcm2835-analog-audio
Date: Tue, 21 Mar 2017 12:59:57 -0500
Message-ID: <CAL_JsqJEHiuLTvUPZ3+jamzQ5sarTGokRuLdBap9g+xPvPvryA@mail.gmail.com>
References: <20170312063820.19313-1-mzoran@crowfest.net>
 <20170320165009.ylrohjwettdy2lgf@rob-hp-laptop>
 <1490029654.11105.7.camel@crowfest.net>
 <CAL_JsqJrLjqobGEWuvrOrU_wXmADUTAXbDRTaE-ukpE6sHRYLQ@mail.gmail.com>
 <1490103037.11105.30.camel@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3637F267194
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 19:00:28 +0100 (CET)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id F2E3E2035D
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 18:00:20 +0000 (UTC)
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
 [209.85.161.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AFE4203C4
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 18:00:18 +0000 (UTC)
Received: by mail-yw0-f176.google.com with SMTP id v76so115071592ywg.0
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 11:00:18 -0700 (PDT)
In-Reply-To: <1490103037.11105.30.camel@crowfest.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Zoran <mzoran@crowfest.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Stefan Wahren <stefan.wahren@i2se.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 21, 2017 at 8:30 AM, Michael Zoran <mzoran@crowfest.net> wrote:
> On Tue, 2017-03-21 at 07:53 -0500, Rob Herring wrote:
>> On Mon, Mar 20, 2017 at 12:07 PM, Michael Zoran <mzoran@crowfest.net>
>> wrote:
>> > On Mon, 2017-03-20 at 11:50 -0500, Rob Herring wrote:
>> > > On Sat, Mar 11, 2017 at 10:38:17PM -0800, Michael Zoran wrote:
>> > > > Add documentation for the DMA properties required when using
>> > > > the
>> > > > PWM controller of the bcm2835 for analog audio output.
>> > > >
>> > > > Signed-off-by: Michael Zoran <mzoran@crowfest.net>
>> > > > ---
>> > > >  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 9
>> > > > ++++++++-
>> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-
>> > > > bcm2835.txt
>> > > > b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
>> > > > index cf573e85b11d..08fc06fc083a 100644
>> > > > --- a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
>> > > > +++ b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
>> > > > @@ -1,14 +1,21 @@
>> > > >  BCM2835 PWM controller (Raspberry Pi controller)
>> > > >
>> > > >  Required properties:
>> > > > -- compatible: should be "brcm,bcm2835-pwm"
>> > > > +- compatible: should be "brcm,bcm2835-pwm" or "brcm,bcm2835-
>> > > > analog-audio"
>> > >
>> > > Compatibles are not for selecting usage modes. You should
>> > > describe
>> > > the
>> > > connection to the pwm that makes it an audio output rather than
>> > > change
>> > > the compatible.
>> > >
>> >
>> > Cool, that's good to know that someone let me know after all this
>> > time.
>>
>> Well, there are more submitters than reviewers and maintainers and we
>> have travel and vacation (aka lives).
>>
>> >  And please tell how if DT nodes are an exact documentation of the
>> > hardware how are virtualized DT nodes like firmware getting into
>> > the
>> > DTs?
>>
>> DT is software's view of the hardware. Firmware provides interfaces
>> to
>> the OS just like a h/w device does. And just like h/w devices, the
>> firmware is not discoverable and needs to be described. Originally,
>> DT
>> was the firmware's interface to the OS with OpenFirmware.
>>
>> Rob
>
> OK, I understand better know.  So it sounds like what I really want to
> do is be able to keep the existing DT as much as possible but load an
> alternative driver.   Presumably at the request of the end user some
> how.
>
> I'm not sure something like that is supported in the linux kernel.  For
> this specific example, I don't know of any reason I couldn't write a
> replacement driver for the existing PWM control that does both audio
> and standard PWM, but I've heard replacing existing drivers is really
> accepted and having alternative drivers isn't something that's
> supported.

2 drivers for the same compatible would be a bit of a problem without
any other information to tell one of the drivers not to probe.

What I had in mind was adding a pwm-audio node (describing what's
connected to the PWM output) similar to what we have for
pwm-backlight. We already have pwm-beeper as well. In theory, then a
pwm-audio driver could work with any PWM. In reality, the overhead
would be too high for dumb PWMs. You would need some batching support
in the PWM subsystem in order to use DMA effectively, and I don't know
if the PWM subsystem supports that currently.

Rob
