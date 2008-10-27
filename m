From: Liam Girdwood <lrg@kernel.org>
Subject: Re: ASOC: For SND_SOC_DAIFMT_IB_IF what
	is	invert	baseed on?
Date: Mon, 27 Oct 2008 11:26:51 +0000
Message-ID: <1225106811.28382.111.camel@dell-desktop.example.com>
References: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
	<1225037126.28382.85.camel@dell-desktop.example.com>
	<4e090d470810262000t3d93538i3a71f5e5d042dd2f@mail.gmail.com>
	<1225104379.28382.104.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 98DEB24707
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 12:26:58 +0100 (CET)
In-Reply-To: <1225104379.28382.104.camel@dell-desktop.example.com>
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

On Mon, 2008-10-27 at 10:46 +0000, Liam Girdwood wrote:
> On Mon, 2008-10-27 at 11:00 +0800, Richard Zhao wrote:

> > 
> > But when wm8350 in i2s mode, it take SND_SOC_DAIFMT_NB_NF as LRCLK is
> > 0 for frame start.
> 
> I2S frame start is the LRC going high (from low) to indicate left
> channel PCM data is available after the next bit clock.
> 

Correction. I've just noticed my datasheet is wrong here.

I2S LRC Left = low, right = high.

So frame start is LRC going low from high.

Liam
