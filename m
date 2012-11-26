From: Paolo Doz <paolo.doz@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: ak5702: add support for ak5702
 -- 4ch ADC
Date: Mon, 26 Nov 2012 17:14:58 +0100
Message-ID: <CAFsPKCVmLx_zqQVspNCjeGL-i8nJoyu7t11CB4PUjk4oKwJv_w@mail.gmail.com>
References: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
 <20121029160450.GB4511@opensource.wolfsonmicro.com>
 <CAFsPKCUXU6OYWQNGy8VOuG-Z=tB81CVbfQtbhq35N2gf4PkX2w@mail.gmail.com>
 <20121029181734.GI4511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id F219B2650F3
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 17:14:58 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d4so6038865eek.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 08:14:58 -0800 (PST)
In-Reply-To: <20121029181734.GI4511@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 29, 2012 at 7:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On Mon, Oct 29, 2012 at 06:49:18PM +0100, Paolo Doz wrote:
>
> Please don't top post.
>
> > @Lars-Peter: thanks for the code review
> > @Mark: You're right. The original source code (that I found on the web)
> > was for kernel 2.6.35, and then I adapted it to work with kernel 3.2 series.
> > Can you suggest me a "state of the art" codec driver where can
> > I have a look at best practice?
>
> Anything that's been getting work recently...  wm8731 is probably
> similar to what you have there.
>
> > In the end the codec should work with alsa infrastructure available in
> > kernel 3.2 so I can test it's correctness directly on my hw.
>
> That's a *very* old kernel now, any mainline submissions should be
> against a current development kernel.


Hi,
I'm rewriting the ak5702 codec driver following you suggestions.
>From you space should be possible to select input source. The codec
has 2 ADC with 2 differents inputs and another one shared by both
(input5)

Inside the codec the input selection is made in the following way

8 bit register (ie ADC A)
bit 0 -> select left1 or left2
bit 1 -> select right1 or right2

bit2/3/4 other settings

bit5 -> if 1 select left5 otherwise select (left1 or left2) depending on bit0
bit6 -> if 1 select right5 otherwise select (right1 or rigth2) depending on bit1

Is there any SOC_ENUM that can be used to represent this situation? I
mean something like "Left1, Left2, Left5" ?

At the moment I have one SOC_ENUM to select "Left1, Left2" and another
for "Left1/2, Left5"

Thanks,
Paolo
