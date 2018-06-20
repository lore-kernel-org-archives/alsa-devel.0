From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: ASoC: new ac97 bus and codec clock
Date: Wed, 20 Jun 2018 19:04:12 +0200
Message-ID: <87y3f9peyb.fsf@belgarion.home>
References: <87lgbdqixh.fsf@belgarion.home>
 <20180619150204.GF11230@sirena.org.uk>
 <CAL_JsqLn2t-zFi8xrig_63OD-SBq8d0jZctih38sZ4cAnRoe6g@mail.gmail.com>
 <8736xhqzmn.fsf@belgarion.home>
 <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr
 [80.12.242.128])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA8D266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 19:04:14 +0200 (CEST)
In-Reply-To: <CAL_JsqJbXGLO+xu1NZOiqmrukHKWUySv=0Sk5KDmSTLL7Mt7+Q@mail.gmail.com>
 (Rob Herring's message of "Wed, 20 Jun 2018 09:10:49 -0600")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Rob Herring <robh+dt@kernel.org> writes:

> On Wed, Jun 20, 2018 at 8:52 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Rob Herring <robh+dt@kernel.org> writes:
Hi Rob,

>>         wm9713@0 {
>
> audio-codec@0
Sure.

>>                 reg = <0>; /* Codex index (between 0 and 3) */
>>                 compatible = "ac97-codec";
>
> This should be something with 'wm9713' in it or if there are ID
> registers you can base it on that.
Well, let's discuss that.
If I take as an example sdio, in mmc-card.txt, the compatible string is
"mmc-card", which describes the "kind" of subnode it is, not _exactly_ the
subnode it is.

If the purpose for this compatible string is to filter the child nodes which are
only ac97 codecs, so that the ac97 framework can act upon them (ie. acquire the
clock for example), then wm9713 is too specific ... That won't work for another
device with an Analog Devices AD1835 for example.

>>                 clocks = <&fixed_wm9713_clock>;
>>                 clock-names = "ac97_clk";
>
> This is the standard 12MHz clock?
Yes it is. The name comes from the original ac97 review, and is in
ac97_get_enable_clk().

Cheers.

-- 
Robert
