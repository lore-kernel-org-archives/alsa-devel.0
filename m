From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Why use spin_lock or spin_lock_irq in trigger
 callback (audio capture)?
Date: Fri, 26 Feb 2010 10:05:43 +0100
Message-ID: <4B878EE7.2010200@ladisch.de>
References: <e5baf3861002251332n7333fb12tb15b055baffaa4a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CFEA1243F8
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 10:05:45 +0100 (CET)
In-Reply-To: <e5baf3861002251332n7333fb12tb15b055baffaa4a2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yiliang Bao <yiliangb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yiliang Bao wrote:
> I looked at some PCI audio capture driver like BT878 (sound/pci/bt87x.c) or
> SAA7134 (drivers/media/video/saa7134-alsa.c), I found that spin_lock instead
> of spin_lock_irq (or spin_lock_irqsave) is used in trigger function. Is
> there any reason for that?

Yes, the trigger callback is called with interrupts already disabled.
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s08.html


Regards,
Clemens
