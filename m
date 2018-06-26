From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
	support
Date: Tue, 26 Jun 2018 11:20:37 +0800
Message-ID: <CAGb2v64v4DEsXL4M2SsjjABgvOwANDQfGOTum0kL_JMYJ+vbug@mail.gmail.com>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk> <1529926289.2900.26.camel@baylibre.com>
 <CAGb2v64D=DC02vVfwJj3XHwQTcAeS6y6fujdj2v=f5O5QHmLxg@mail.gmail.com>
 <20180625123952.GJ9413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 914E92673F5
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 05:20:59 +0200 (CEST)
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so52726edo.13
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:20:59 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com.
 [74.125.82.44])
 by smtp.gmail.com with ESMTPSA id b20-v6sm204291edr.26.2018.06.25.20.20.58
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Jun 2018 20:20:58 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id w137-v6so98147wmw.1
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:20:58 -0700 (PDT)
In-Reply-To: <20180625123952.GJ9413@sirena.org.uk>
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
Cc: Hans de Goede <hdegoede@redhat.com>, Linux-ALSA <alsa-devel@alsa-project.org>, =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 25, 2018 at 8:39 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 25, 2018 at 08:28:32PM +0800, Chen-Yu Tsai wrote:
>
>> I think slightly different semantics apply for "shutdown" vs "mute"
>> pins / controls.
>> "shutdown" implies a low power, if not powered off altogether, mode which might
>> require a slight delay to charge up when the amp is enabled. "mute" is
>> just that,
>> disconnecting the output, which would be useful in masking pops or other noises,
>> but does nothing to help power consumption.
>
>> Not sure if the subtle differences can be handled in DAPM, but it would be nice
>> to have. I've seen devices that have both control pins.
>
> It's certainly potentially useful to have pins for both and treat them
> differently - ideally something that's a mute would get autodisable type
> treatment so we mask out any pops in the input path but also make it
> available to userspace if it needs it.  That's something that could be
> done when the need arises though, until something that actually has both
> controls appears handling a mute pin like a power control is probably
> going to result in the most reliable integration.

Agreed. I'll dig around to see which one of my devices has this.

> Having the binding specify both differently would be good for future
> proofing.

Ack.

Also, would it be possible to specify the name or prefix of the widgets
from the device tree, such that it would be possible to have multiple
instances? I'm thinking one amp for speakers, and one for headphones,
each individually controlled.

ChenYu
