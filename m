From: Anthony Tzouris <anthony@ideal-enterprises-inc.com>
Subject: disconnect between ported driver (kernel) and alplay
	(userspace)
Date: Fri, 03 Jan 2014 13:40:15 -0800
Message-ID: <52C72E3F.4030604@ideal-enterprises-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 911EC261A48
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 22:40:17 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AA2FB20D2B
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 16:40:16 -0500 (EST)
Received: from [10.0.0.20] (unknown [76.212.152.120])
 by mail.messagingengine.com (Postfix) with ESMTPA id 317C2C00E87
 for <alsa-devel@alsa-project.org>; Fri,  3 Jan 2014 16:40:16 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

_Hardware/Software Platform_

  * Custom Hardware based on Freescale i.MX28EVK platform
  * Original Codec Freescale SGTL5000 on Freescale i.MX28EVK platform
  * Ported a Codec Texas Instruments PCM1681
  * Embedded Linux using Freescale LTIB 2013 (linux kernel 2.6.35.3) distribution

_Good News_

I have the I2S clocks verified with digital scope on the hardware for the
desired 256 * fs, 64 * fs, and fs.

_Bad News_

Audio when played out with aplay and a 44.1 kHz S16_LE Stereo file plays out too
fast (guesstimating about 3 times too fast).

_Due Diligence_

I've been digging through the linux kernel code to figure out why my driver is
passing the incorrect fs (sample rate) up to the linux kernel alsa subsystem
between aplay and my pcm1681 device driver.  I've forced the driver to only run
44.1kHz (which shows up everwhere from my kernel debug printk) and that is what
is showing up with a scope on the hardware fs clock with a digital scope but ...
between aplay and the driver, there is a perception of a lower sample rate
needed, therefore there is a rate reduction of the sample sequence which makes
the audio clip play faster out on the audio port.

I've been digging through the code and trying different things for a few days
now and I have not made any progress.

_Help/Advice/Understanding Needed_

What I need to understand is how from aplay down through the alsa layer in the
kernel the sample rate is set down to the driver layer ... and in the reverse
direction.

Of course the kernel is patched by Freescale so I'm not exactly sure how to ask
for help on this but perhaps there is a way to get some ideas from the aplay
(userspace layer) down through the alsa kernel layer that I can look at that
might downsample the audio file before it gets to the driver.

Using

alsa-lib-1.0.24.1
alsa-utils-1.0.24.2

My idea is to approach debug from the userspace down versus the driver porting
which was from the lowest level (driver layer) and up.  That is why I'm posting
on alsa-devel as I think that this is where I need to focus where the sample
rate misconception is and thereby where the downsampling is occurring which is
either in userspace (alsa-lib) code or possibly alsa layer kernel code.

Looking to leverage some alsa knowledge and expertise.

-- 
Anthony
