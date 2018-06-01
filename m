From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Fri, 1 Jun 2018 09:21:52 -0500
Message-ID: <CAL_Jsq+NNpersC0wy1tnoEh3yfSXJ+W_0B0UMHzoEDdZqyUZ=Q@mail.gmail.com>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
 <20180529112447.GC23509@sirena.org.uk>
 <f130a86f-deca-b5cf-da34-5cf52a9c39fc@zonque.org>
 <20180531170240.GA29973@rob-hp-laptop>
 <d5df3c6b-22ae-408b-5727-516fed648b2a@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id B6D76267734
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 16:22:14 +0200 (CEST)
Received: from mail-qt0-f170.google.com (mail-qt0-f170.google.com
 [209.85.216.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63E5F208B4
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 14:22:13 +0000 (UTC)
Received: by mail-qt0-f170.google.com with SMTP id d3-v6so32314373qtp.11
 for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2018 07:22:13 -0700 (PDT)
In-Reply-To: <d5df3c6b-22ae-408b-5727-516fed648b2a@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 31, 2018 at 3:03 PM, Daniel Mack <daniel@zonque.org> wrote:
> On Thursday, May 31, 2018 07:02 PM, Rob Herring wrote:
>>
>> On Tue, May 29, 2018 at 10:23:48PM +0200, Daniel Mack wrote:
>
>
>>> If that's the case, could you depict how the DT bindings should look like
>>> by
>>> example?
>>
>>
>> In clock providers, you just add #clock-cells. Then the consumer side
>> defines 'clocks'. Which clock(s) comes from the dai is defined by the
>> index in the 'clocks' property for that node.
>>
>> Both ends can be providers, but who is active is determined by defining
>> the actual connections with 'clocks'. Or perhaps you have both
>> directions shown and there is some other means to select which one is
>> active such as solving for who can provide the desired freq.
>
>
> How about entities that are a clock producer and consume their clocks
> themselves? That's a rather typical thing for DAIs. Is that expressible in
> DT?

And I assume something else consumes those clocks, too? If not, you
can just handle all that within the driver and don't need the clock
binding or clock framework.

But yes, you can do something like this:

myclk: clock-controller {
  #clock-cells = <1>;
  clocks = <&myclk 123>, <&otherclk 1>;
};

You'll have to handle clk registration and clk_get in the right order
to avoid deferring probe on yourself.

Rob
