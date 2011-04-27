From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: prevent compilers from optimising pll
	calculation into __aeabi__uldivmod
Date: Wed, 27 Apr 2011 13:10:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104271305580.24613@xanadu.home>
References: <74CDBE0F657A3D45AFBB94109FB122FF0497F1AA8C@HQMAIL01.nvidia.com>
	<BANLkTima_RChkz07Vdno8vMt-J=KOen6rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <BANLkTima_RChkz07Vdno8vMt-J=KOen6rg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Barry Song <bs14@csr.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Zhiwu Song <zhiwu.song@csr.com>, Binghua Duan <binghua.duan@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Apr 2011, Barry Song wrote:

> 2011/4/27 Stephen Warren <swarren@nvidia.com>:
> > Barry Song wrote at Wednesday, April 27, 2011 1:28 AM:
> >> The newest compiliers can optimize pll calculation in several codecs into
> >> __aeabi__uldivmod which doesn't exist in kernel.
> >> Then the link will fail:
> >> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8974.ko] undefined!
> >> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8940.ko] undefined!
> >> ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-wm8510.ko] undefined!
> >> This patch prevent the optimizaton by insert ASM.
> >
> > Aren't there compiler flags that tell gcc it isn't operating in a hosted(?)
> > environment, and hence not to emit calls to these functions? If so, I
> > imagine they should be added to the kernel's core (or ARM arch ) makefiles.
> >
> > I doubt __aeabi_uldivmod is the only function of this type. How was this
> > solved for other such functions; does the kernel implement the AEABI
> > functions, and this implementation is simply missing?
> 
> __aeabi_uldivmod is not implemented by kernel, others are implemented
> in arch/arm/lib/lib1funcs.S:
> extern void __aeabi_idiv(void);
> extern void __aeabi_idivmod(void);
> extern void __aeabi_lasr(void);
> extern void __aeabi_llsl(void);
> extern void __aeabi_llsr(void);
> extern void __aeabi_lmul(void);
> extern void __aeabi_uidiv(void);
> extern void __aeabi_uidivmod(void);
> extern void __aeabi_ulcmp(void);

This is not the point.  uldivmod will not be implemented on purpose 
because this is a kernel policy _not_ to create any code that would 
require it.

And the description above is wrong too.  It's not about "the newest 
compiler can optimize ..." but rather "the newest compiler has a bug 
that leave a stray reference to __aeabi_uldivmod in the compiled 
object."  As far as I'm concerned, the code is fine as is.  It is the 
compiler that is wrong.


Nicolas
