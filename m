From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: SGTL500 and its external MCLK
Date: Fri, 8 Aug 2014 13:07:46 -0400
Message-ID: <CAKON4OwgT8=moQUPugpR8CfPNkJomDGpHob0CRnzRSd4eC7kQg@mail.gmail.com>
References: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
 <20140808052901.GA6028@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C08026554F
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 19:07:47 +0200 (CEST)
Received: by mail-lb0-f178.google.com with SMTP id c11so4000847lbj.37
 for <alsa-devel@alsa-project.org>; Fri, 08 Aug 2014 10:07:46 -0700 (PDT)
In-Reply-To: <20140808052901.GA6028@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, zengzm.kernel@gmail.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 8, 2014 at 1:29 AM, Nicolin Chen <Guangyu.Chen@freescale.com> wrote:
> On Thu, Aug 07, 2014 at 03:37:47PM -0400, jonsmirl@gmail.com wrote:
>> Since the sgtl5000 driver has the handle to the clock, can't it just
>> ask the clock for its rate? If it directly asked the clock for its
>> rate it looks like this codec could be bound with simple-audio-card
>> and not need a machine driver.
>
> I think Simple Card should already have the capability to support
> this without changing sgtl5000's code. It has two properties that
> can make it call set_sysclk() for you during the init(). They are
> 'clocks' and 'system-clock-frequency'. Please refer to its binding
> doc for details.
>
> And the topic why not let sgtl5000 fully control the clock has been
> discussed in this thread:
> http://comments.gmane.org/gmane.linux.alsa.devel/109093
>
> So I think the change can be done as well?

I tried hacking on it some. One problem is with clocks that aren't
100% accurate. For example my clock is off a little - 22.571428. So
when the code divides that by 44100 it gets 511.8 which truncates to
511 and the test for equal to 512 fails.


>
> Best regards,
> Nicolin



-- 
Jon Smirl
jonsmirl@gmail.com
