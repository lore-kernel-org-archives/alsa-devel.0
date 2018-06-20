From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 20 Jun 2018 11:16:15 -0600
Message-ID: <CAL_JsqKBOdZBuDnRUAcpARP1fFquc7vpcUayYRaJAMSPrhsPdg@mail.gmail.com>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 <8736xhqzmn.fsf@belgarion.home>
 <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
 <87y3f9peyb.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 819FC2673CF
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 19:16:37 +0200 (CEST)
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
 [209.85.214.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4199820875
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 17:16:36 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id y127-v6so74778itd.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 10:16:36 -0700 (PDT)
In-Reply-To: <87y3f9peyb.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 20, 2018 at 11:04 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Rob Herring <robh+dt@kernel.org> writes:
>
>> On Wed, Jun 20, 2018 at 8:52 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Rob Herring <robh+dt@kernel.org> writes:
> Hi Rob,
>
>>>         wm9713@0 {
>>
>> audio-codec@0
> Sure.
>
>>>                 reg = <0>; /* Codex index (between 0 and 3) */
>>>                 compatible = "ac97-codec";
>>
>> This should be something with 'wm9713' in it or if there are ID
>> registers you can base it on that.
> Well, let's discuss that.
> If I take as an example sdio, in mmc-card.txt, the compatible string is
> "mmc-card", which describes the "kind" of subnode it is, not _exactly_ the
> subnode it is.

"mmc-card" is only for memory cards which are pretty much all the same
and rarely have a node, but SDIO devices always have a specific
compatible.

Does AC97 specify a common programming model? That's were a common
compatible is used (though experience has proven things like
"generic-ehci" are don't work).

It's generally a bad design to mix different types of subnodes, so I
was assuming all child nodes would be the same type. For example, you
can only have 1 address space (i.e. reg definition). If you need
different types, you need to add a level of nodes.

>
> If the purpose for this compatible string is to filter the child nodes which are
> only ac97 codecs, so that the ac97 framework can act upon them (ie. acquire the
> clock for example), then wm9713 is too specific ... That won't work for another
> device with an Analog Devices AD1835 for example.

Are there ID registers? If so, then just construct a compatible string
from them and just find the compatible child node. See USB bindings
for an example using VID/PID.

Rob
