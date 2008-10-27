From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASOC: For SND_SOC_DAIFMT_IB_IF what is
	invert	baseed on?
Date: Mon, 27 Oct 2008 13:47:27 +0000
Message-ID: <1225115247.28382.129.camel@dell-desktop.example.com>
References: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
	<1225037126.28382.85.camel@dell-desktop.example.com>
	<4e090d470810262000t3d93538i3a71f5e5d042dd2f@mail.gmail.com>
	<1225104379.28382.104.camel@dell-desktop.example.com>
	<4e090d470810270624l5587d382o78330f737d709b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slimlogic.co.uk (slimlogic.co.uk [89.16.172.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 684F01037FA
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 14:47:28 +0100 (CET)
In-Reply-To: <4e090d470810270624l5587d382o78330f737d709b8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-10-27 at 21:24 +0800, Richard Zhao wrote:
> > Not quite, the clock is simply inverted compared to it's normal level.
> >
> 
> Well, what's the normal level? i2s LRCLK 's normal level is low for
> frame start, but pcm's normal level is high for frame start.
> 
> Different chips may have different meaning of "invert", because
> "normal level" is not well defined. 

normal == standard. 

I2S spec is here :-

http://www.nxp.com/acrobat_download/various/I2SBUS.pdf

and is well defined.

> SND_SOC_DAIFMT_NB_NF is a common
> macro, so it cannot depend on any chip.  So, could you please explain
> in details what normal level and invert level of LRCLK/BCLK are in
> i2s, pcm, left/right justified?
> 

The wm8750 datasheet shows all this in diagrams :-

http://www.wolfsonmicro.com/uploads/documents/WM8750.pdf

It might be easier if you would send in your code so we can see what you
are trying to accomplish. 

Liam
