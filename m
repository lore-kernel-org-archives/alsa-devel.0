From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 14:00:22 -0400
Message-ID: <CAKON4OyyPhH9=kRRxkmFJGcvzWTBdZ2_d449FCAzE+6jy5XFKg@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
 <20140811171133.GG17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id C08D9261647
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 20:00:22 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id gl10so6902137lab.21
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 11:00:22 -0700 (PDT)
In-Reply-To: <20140811171133.GG17528@sirena.org.uk>
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

On Mon, Aug 11, 2014 at 1:11 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 11, 2014 at 12:09:43PM -0400, jonsmirl@gmail.com wrote:
>> On Mon, Aug 11, 2014 at 11:33 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > No, the machine driver runs first so it can do any coordination needed
>> > between the other devices.  Attempting to fiddle about with the ordering
>> > is never going to be robust, someone else will always want a different
>> > ordering at some point.
>
>> I don't see how to fix this without making a machine driver that
>> simply tells the cpu-dai to change the MCLK output from 22.5Mhz to
>> 24.5Mhz earlier in the hw_params chain. But that's putting a generic
>> piece of code into the machine driver.
>
> That's absolutely fine, the clocking arrangements and sequencing
> requirements for achieving it are in general going to depend on the
> machine.  The machine may have requirements which mean that it doesn't
> want to use a clock configuration it's physically possible for it to
> generate, or it may want to do more extensive reparenting depending on
> use case.
>
> For things like this it is generally good practice for the machine
> driver to disable all clocks (set their rates to zero) when disabling if
> it wants to support reconfiguration.
>
>> Shouldn't codec always be the last in the chain? What would be a case
>> where you don't want it at the end of the chain?
>
> How are you deciding what the ordering for "the chain" should be in the
> first place?  It seems like you're just assuming that it's what you want
> to set for your system which in turn appears to be derived from what
> you're using as clock master, it's very common for the CODEC to be the
> clock master in a system.
>
> One could equally argue here that the master shouldn't allow itself to
> have the clock rate reprogrammed when it has something deriving a clock
> from it (after all if that thing is running it might be disrupted).

We probably need something like EPROBE_DEFER that is used in the
driver subsystem to allow that various pieces to so this out.

-- 
Jon Smirl
jonsmirl@gmail.com
