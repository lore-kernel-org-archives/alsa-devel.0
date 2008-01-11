From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: dmix without mmap support in soundcard driver
Date: Fri, 11 Jan 2008 16:01:36 +0100
Message-ID: <1200063696.7074.18.camel@md40100b.ft>
References: <BAY110-W2718CB754898850E2E81F3C9520@phx.gbl>
	<1199614535.5983.13.camel@md40100b.ft>
	<200801082258.15166.rgetz@blackfin.uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id AD06924598
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 16:01:38 +0100 (CET)
In-Reply-To: <200801082258.15166.rgetz@blackfin.uclinux.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: cailinhua <xcahua@hotmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Robin,

On Tue, 2008-01-08 at 22:58 -0500, Robin Getz wrote:
> OK - I see in:
> 
> http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/x1405.htm
> 
> I assume that is what you mean?

Exactly, yes.

> If so, I'm still confused - since the pcmcia/vx (vxpocket driver) doesn't seem 
> to do that... ??

Hmmm, I never looked at the vxpocket driver ....

> I do see the driver in pci/rme32.c - it is using pcm-indirect.h and the 
> snd_pcm_indirect_xxx functions - if that is the one we should be looking at?

Yes. rme32.c is a good example.

> My only question is - if you allow a mmaped intermediate buffer, how does the 
> driver notice when ALSA writes into this buffer?

It's the ack() callback. ALSA writes/reads something into/from the
intermediate buffer and calls the driver's ack() callback - if there is
any. In the ack() callback the driver should call one of the
snd_pcm_indirect_*_transfer() functions. There, the difference between
current and last seen appl_ptr gives the "new position" of the PCM Layer
in your intermediate buffer (where it will write/read next time).

 Joachim
