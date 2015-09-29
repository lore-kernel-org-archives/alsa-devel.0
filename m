From: Rick Mann <rmann@latencyzero.com>
Subject: Re: Kernel Device Tree entries for simple-audio-card
Date: Mon, 28 Sep 2015 23:31:10 -0700
Message-ID: <7CCA3F5A-844A-43FF-9A4E-C0A9FB65D926@latencyzero.com>
References: <4D7C68FE-B884-489C-91DD-395FE7CE181D@latencyzero.com>
 <CAG5mAdxc5-UuTnz24zByA64ZsrB4qnfMKF57GBVeFfWvY44xsw@mail.gmail.com>
 <4D1E67E6-437D-490D-A577-35EB7E474A3A@latencyzero.com>
 <CAG5mAdxnjZUBiOFU6+MBn0znUCBaGpeVQ-RaYhXch=-4n7J4uw@mail.gmail.com>
 <F3A7E580-2E91-45D0-9C27-2FD190110686@latencyzero.com>
 <CAG5mAdxgTzGjnvwno0D_Jo9_53stmGfsc9OQS05f3thrSFKpkw@mail.gmail.com>
 <BE1F1488-2A4D-4EE6-A538-931DD0B34CD8@latencyzero.com>
 <CAG5mAdzg2BSGKiaBJVSgZvL=9wxffxv_3LMiruS2-kcuTKO+xQ@mail.gmail.com>
 <D8BC8B49-E32C-43EE-B181-60510C7B3E8E@latencyzero.com>
 <CAG5mAdxaAapawiaaR_zasVhQKL33MHEHP1yyUCSLv0wswZ9Law@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D15F326058D
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 08:31:12 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 37ADD2032C
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 02:31:12 -0400 (EDT)
In-Reply-To: <CAG5mAdxaAapawiaaR_zasVhQKL33MHEHP1yyUCSLv0wswZ9Law@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> On Sep 28, 2015, at 23:27 , Caleb Crome <caleb@crome.org> wrote:
> 
>  
> On Mon, Sep 28, 2015 at 5:08 PM, Rick Mann <rmann@latencyzero.com> wrote:
> 
> > On Sep 28, 2015, at 16:46 , Caleb Crome <caleb@crome.org> wrote:
> >
> > Hmm, the pinmux looks right, except that you have your TX set as an input.  You should have this:
> >
> > mymcasp1_pins_default: mymcasp1_pins_default {
> >       pinctrl-single,pins = <
> >               0x1ac ( PIN_OUTPUT | MUX_MODE0 ) /* (A14) mcasp0_ahclkx.mcasp0_ahclkx */
> >               0x190 ( PIN_INPUT | MUX_MODE0 ) /* (A13) mcasp0_aclkx.mcasp0_aclkx */
> >               0x194 ( PIN_INPUT | MUX_MODE0 ) /* (B13) mcasp0_fsx.mcasp0_fsx */
> >               0x198 ( PIN_INPUT | MUX_MODE0 ) /* (D12) mcasp0_axr0.mcasp0_axr0 */
> >               0x19c ( PIN_OUTPUT | MUX_MODE2 ) /* (C12) mcasp0_ahclkr.mcasp0_axr2 */
> >       >;
> > };
> 
> The DTBO for the Audio Cape didn't mark the TX as an output, but I surely can try that.
> 
> That's because you didn't tell it to :-)  There's checkbox you need to uncheck to make it  Tx.  It's an uncelar UI.  You uncheck Rx to make it a Tx. 

What I mean is, the Audio Cape's DTBO (.dts, really), has the modes on all but the WCLK as 0x20 (one is 0x22). That makes them all inputs. Only WCLK is 0x00. Even if it's for the BB White and not Black, that part wouldn't change.

> That won't get your clocking going unfortunately.  
> 
> Also, the DTBO I found for the audio cape is for the BeagleBone, not the BeagleBoneBlack, so that threw me for a while.
> 
> also, I got things running using the audio cape and the davinci-evm.c device tree entry, not the simple-audio-card.  I ended up putting a lot of printk's into the kernel so I could trace out how the whole thing worked.  
> 
> Your fundamental problem seems to be in getting the McASP's output clock going.  Once that's going, then you can worry about getting the codec's PLL to output BCLK and WCLK.
> 
> Look through the davinci-evm.c and see what it does that simple-audio-card doesn't.  It's something to do with the MCLK for sure.

Could you send me your DTS?

> 
> Once your MCLK is going, you can use i2cdump to look at the codec registers:
> 
> sudo i2cdump -f -y 1 0x18
> 
> or similar.

Yeah, that works.


-- 
Rick Mann
rmann@latencyzero.com
