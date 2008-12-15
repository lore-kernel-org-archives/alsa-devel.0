From: Jean-Pierre ANDRE <jean-pierre.andre@wanadoo.fr>
Subject: Re: Intel 82801I (ICH9 Family) HD Audio Controller on
 a HP	dv4 computer
Date: Mon, 15 Dec 2008 11:10:12 +0100 (CET)
Message-ID: <17030499.155080.1229335812686.JavaMail.www@wwinf1a21>
References: <7342920.39901.1229168483619.JavaMail.www@wwinf1b34>
	<s5hvdtn15ps.wl%tiwai@suse.de> <4944E56D.9020505@wanadoo.fr>
	<s5hskopq44n.wl%tiwai@suse.de>
Reply-To: Jean-Pierre ANDRE <jean-pierre.andre@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1a.orange.fr (smtp1a.orange.fr [193.252.23.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 6815C10380A
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 11:10:13 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1a02.orange.fr (SMTP Server) with ESMTP id BAB9C7000086
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 11:10:12 +0100 (CET)
In-Reply-To: <s5hskopq44n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Than you for your help.

> 
> Switching to polling mode is OK and mostly harmless.  But single_cmd
> is not.  There is a VERY big difference between them.

Ok.

> > Probably related is the
> > fact that I have never seen an IRQ 22. 
> > 
> > from proc/interrupts :
> > 
> >  22:          0          0   IO-APIC-fasteoi   uhci_hcd:usb6, HDA Intel
> 
> Hum, then it must be an interrupt thing.
> Ask rather ACPI guys.
> 

Well, you must be right. Using the irqpoll boot option,
the sound is correct, and I see four IRQ 20 per second
(and none when there is no sound).

1) Can you confirm an expected IRQ every 250ms ?

The APIC routes PCI INT B to IRQ 22, and alsa is
expecting IRQ 22. Now I have to get alsa to expect
IRQ 20 or get APIC to route an appropriate PCI INT
to IRQ 22....

2) Now I get a warning "hda-intel: IRQ timing workaround
 is activated for card #0. Suggest a bigger bdl_pos_adj."

What is the range of values I should try ?

Regards

Jean-Pierre
