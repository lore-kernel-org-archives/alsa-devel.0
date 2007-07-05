From: Paul Vojta <vojta@Math.Berkeley.EDU>
Subject: Re: another device for opl3sa2
Date: Thu, 5 Jul 2007 01:03:02 -0700
Message-ID: <20070705080302.GA6818@math.berkeley.edu>
References: <20070703002739.GA27389@math.berkeley.edu>
	<s5hfy45ajk1.wl%tiwai@suse.de>
	<20070704022423.GA2012@math.berkeley.edu>
	<s5h4pkka6tq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.math.berkeley.edu (mail.math.Berkeley.EDU [169.229.58.57])
	by alsa0.perex.cz (Postfix) with ESMTP id A151B1038C6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 10:03:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4pkka6tq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 04, 2007 at 10:53:05AM +0200, Takashi Iwai wrote:
> At Tue, 3 Jul 2007 19:24:23 -0700,
> 
> Hm, the silence appears to be an insufficient mixer initialization.
> Touching mixer values doesn't help?

Not sure what you mean by "touching mixer values".  I tried running
alsamixer and immediately hitting Escape, but the bug still occurred.

By the way, if I use the cs-4232 driver instead, then I don't experience
the problem.  Of course, with cs-4232 the PNP is all wrong, so I used a
non-pnp kernel with:

modprobe snd-cs4232 \
  port=0x534 cport=0x120 mpu_port=0x330 fm_port=0x388 sb_port=0x220 \
  irq=5 dma1=0 dma2=1

For comparison, the settings for opl3sa2 would be:

  sb_port=0x220 wss_port=0x530 fm_port=0x388 midi_port=0x330 port=0x370 \
  irq=5 dma1=0 dma2=1


--Paul Vojta, vojta@math.berkeley.edu
