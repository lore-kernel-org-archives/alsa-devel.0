From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 03 Sep 2009 15:05:59 +0200
Message-ID: <4A9FBF37.6030106@ladisch.de>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>	<4A9E9CB7.8040809@ladisch.de>	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>	<4A9FAD82.3050207@ladisch.de>
	<7c5010d60909030529w7f226cc1s18c80f1eb0deab3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1768B2452E
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 15:06:04 +0200 (CEST)
In-Reply-To: <7c5010d60909030529w7f226cc1s18c80f1eb0deab3a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Giovanni Maruzzelli wrote:
> Yes, CONFIG_PREEMPT* are probably different between the various
> kernels, and also the compiled kernel is tickless.
> 
> But, this is a problem only with snd-dummy.

The interrupts of other drivers are based on the PCM stream clock, but
the snd-dummy driver has to emulate interrupts using the system timer,
so it is the only one affected by timer-related changes.

> What I would like, in the interest of users, is snd-dummy to be
> modified in a way that makes it working on the regular CentOS-RHEL
> kernels,

The driver relies on the kernel's system timer.  It might be possible
to rewrite it to use high-resolution timers, if the CentOS kernels
supports it.

It would be easier to try to change the constraints of the sound card
that snd-dummy tries to emulate; set USE_PERIODS_MIN to four or so,
and increase period_bytes_min to some value that is at least as large
as the numer of bytes per timer tick (with 2 channels and 16 bits at
48 kHz, there are 192000 bytes per second).


HTH
Clemens
