From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: rt5677: handle reset_pin logical
	state correctly
Date: Wed, 28 Oct 2015 12:55:14 -0700
Message-ID: <CAOMFOmVYgTB6jLte=2-hv8EwLHXjyx1CjCU545JGBsvBvGedbw@mail.gmail.com>
References: <1437154736-15320-1-git-send-email-anatol.pomozov@gmail.com>
 <20150814190126.GI10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F76262607
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 20:55:15 +0100 (CET)
Received: by vkfw189 with SMTP id w189so12732549vkf.2
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 12:55:14 -0700 (PDT)
In-Reply-To: <20150814190126.GI10748@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

Returning back to this discussion that slipped away from my mailbox.

On Fri, Aug 14, 2015 at 12:01 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 17, 2015 at 10:38:56AM -0700, Anatol Pomozov wrote:
>> According to the datasheet RESET is active low pin, i.e. system goes to reset
>> state when pin is low.
>>
>> Handle logic state correctly - set reset_pin to logical 0 at boot time, and
>> set it to logical 1 when we need to reset the chip.
>
> I'm a bit confused here - how was the original code (written by you it
> seems...) tested?  This looks like it's fixing the device being held in
> reset when it should be operation which seems like something that'd get
> noticed.  Are there existing systems that the current code works for
> which we need to handle here?

While working with the original patch you mentioned I missed the
active low description at RESET pin. I configured gpio in the dts as
ACTIVE_HIGH and set the logic state to 0 at suspend mode. This puts
the chip into reset state correctly.

Later I discovered correct polarity and given change modifies gpio
properties accordingly. I also changed our dts gpio to ACTIVE_LOW.
Chip reset state still works as expected. The change does not modify
anything at the signalling level, it just adds double negative to the
code. Compare:

pin configured as ACTIVE_HIGH - to move codec out of reset we need to
set gpio logic level to 1. Physical signal is 1.
pin configured as ACTIVE_LOW - to move codec out of reset we need to
set gpio logic level to 0. Gpio becomes non-active that is represented
by physical signal level 1.
