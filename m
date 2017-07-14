From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/18] mfd: madera: Add register
 definitions for Cirrus Logic Madera codecs
Date: Fri, 14 Jul 2017 12:50:59 +0100
Message-ID: <1500033059.4826.139.camel@rf-debian.wolfsonmicro.main>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170713080210.lbsjnmlciovoxe4g@dell>
 <20170713100539.mqvyxgvwqowjim6i@sirena.org.uk>
 <1499949850.4826.88.camel@rf-debian.wolfsonmicro.main>
 <20170713130305.ytrk322lqe6dusla@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AB245266C1E
 for <alsa-devel@alsa-project.org>; Fri, 14 Jul 2017 13:51:03 +0200 (CEST)
In-Reply-To: <20170713130305.ytrk322lqe6dusla@sirena.org.uk>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-07-13 at 14:03 +0100, Mark Brown wrote:
> On Thu, Jul 13, 2017 at 01:44:10PM +0100, Richard Fitzgerald wrote:
> > On Thu, 2017-07-13 at 11:05 +0100, Mark Brown wrote:
> > > On Thu, Jul 13, 2017 at 09:02:10AM +0100, Lee Jones wrote:
> 
> > > > This patch has been rejected by Linus.
> 
> > > > https://lkml.org/lkml/2017/7/7/579
> 
> > > Hrm, when I used to push the register definition patches I did elide all
> > > the obviously repeated register banks like the write sequencer one that
> > > Linus is calling out there.  I'm surprised by the "every single line"
> > > bit though...
> 
> > Linux doesn't say what he wants us to do about it. I could manually
> > strip out a few more definitions but seriously, it makes the code a lot
> > harder to maintain if we can't grep it for use of registers and register
> > fields. They are big chips, they have a lot of stuff in the registers.
> 
> I'd take it up with him, if you can explain why it looks very
> repetitive but isn't actually that'd help...
> 

I would but I haven't subscribed to receive LKML email because of the
high bandwidth, and I'm not sure how thrilled Linus would be if my reply
isn't a reply to his thread.

> Building up copies of the repeated IPs with macros would help too (the
> AIF and especially frame control registers stick out like a sore thumb
> here), as would removing the individual registers for the write
> sequencer block.

Mark: I know you already know what's below so apologies for this. But
for others on this thread interested in why our registers.h is the way
it is...

We really quite like to keep all the registers defined because it makes
the source highly greppable, which is extremely useful. A type of
question which is often asked is "what does the driver do with register
bits XYZ" or "where does it use register bits XYZ". Eliminating
definitions into generator macros or block-indexing code makes these
questions more difficult to answer. Another convenience is that it makes
it easier for people to translate raw hardware configurations (which are
a list of register values) into ALSA and pdata settings if they can
easily grep the source for those registers to see how they are
controlled. It also helps when adapting the driver for another similar
codec.

We do use block-indexing code where it's clearly the only sensible way
to implement a feature. But a lot of the source that uses
repetitive-looking definitions is ASoC tables, not functions, so there's
no code to do block-indexing, and macroing out the register definitions
just makes the table definitions more clunky and less readable but has
no effect on its "quality". I did already strip a lot out of the file to
remove stuff we don't need or we implement as repeated blocks (the
original file is >44000 lines).

As for the naming and the 1-indexed counting, these are the datasheet
names of the registers and we want to use the same name in the source as
is in the datasheet and the hardware design, otherwise it gets
confusing. In fact, the majority are the names of actual wires and
blocks in the hardware design, generated directly from it. Renaming them
is a big deal for the hardware engineers because it's a design change
and you can't patch silicon if it introduces a bug. The 0-indexed
counting is a very C-centric view, hardware designers have other
considerations, as well as avoiding the risk of unnecessary changes.

The WSEQ registers can go but I was hoping to avoid manually stripping
too much more because when there are updated register maps for new chips
or new revisions of existing silicon it must be possible to see what's
changed. As we strip more and more it gets harder work for people to see
in a diff the difference between genuinely removed register bits and
spurious changes from manual edits. However, I can strip out definitions
of bits that we aren't using _right now_ to reduce file size and patch
them back later when we need to use them, though that does mean anyone
debugging (via regmap debugfs for example) has to go to the datasheet to
look for the definitions of all those bits because they are missing from
the source.
