From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 14:24:31 -0400
Message-ID: <CAKON4OwYLc_2KSC7oGB=KU1SYHS_1udkCz9td0OsSx8iC1-wjw@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
 <20140811171133.GG17528@sirena.org.uk>
 <CAKON4OyyPhH9=kRRxkmFJGcvzWTBdZ2_d449FCAzE+6jy5XFKg@mail.gmail.com>
 <20140811181922.GH17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C85B926166B
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 20:24:31 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id pn19so7049047lab.10
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 11:24:31 -0700 (PDT)
In-Reply-To: <20140811181922.GH17528@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2014 at 2:19 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 11, 2014 at 02:00:22PM -0400, jonsmirl@gmail.com wrote:
>> On Mon, Aug 11, 2014 at 1:11 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > That's absolutely fine, the clocking arrangements and sequencing
>> > requirements for achieving it are in general going to depend on the
>> > machine.  The machine may have requirements which mean that it doesn't
>> > want to use a clock configuration it's physically possible for it to
>> > generate, or it may want to do more extensive reparenting depending on
>> > use case.
>
>> We probably need something like EPROBE_DEFER that is used in the
>> driver subsystem to allow that various pieces to so this out.
>
> That really doesn't solve the problem - consider reparenting for
> example.

Maybe it is time to get rid of setsysclk and use the clk
infrastructure? With the clk stuff the order is known by walking the
clk dependency chain.

In my case both sgtl5000 and Allwinner I2S are using clk. But there is
no mechanism for telling ASOC to use this chain to figure out the
ordering.



-- 
Jon Smirl
jonsmirl@gmail.com
