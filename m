From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: ice1712 error
Date: Fri, 19 Dec 2008 16:38:50 +0100
Message-ID: <494BC00A.9080202@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr19.xs4all.nl (smtp-vbr19.xs4all.nl [194.109.24.39])
	by alsa0.perex.cz (Postfix) with ESMTP id CDA9924428
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 16:38:59 +0100 (CET)
Received: from [192.168.10.70] (pindarots.xs4all.nl [80.101.128.228])
	(authenticated bits=0)
	by smtp-vbr19.xs4all.nl (8.13.8/8.13.8) with ESMTP id mBJFcoXu097225
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 16:38:59 +0100 (CET)
	(envelope-from udovdh@xs4all.nl)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I found out the ICE1712 card is sometimes detected OK and sometimes 
isn't detected correctly.
Cold boot/warm boot doesn't really matter.
I tried kernel 2.6.27.9 and older.
Card is is fine when detected.
Behaviour doesn't change when I try a different PCI slot.

When the card fails:

# dmesg|grep 01:09
PCI: 0000:01:09.0 reg 10 io port: [a000, a01f]
PCI: 0000:01:09.0 reg 14 io port: [a400, a40f]
PCI: 0000:01:09.0 reg 18 io port: [a800, a80f]
PCI: 0000:01:09.0 reg 1c io port: [ac00, ac3f]
pci 0000:01:09.0: supports D2
ICE1712: probe of 0000:01:09.0 failed with error -12

When the card is OK:

PCI: 0000:01:09.0 reg 10 io port: [a000, a01f]
PCI: 0000:01:09.0 reg 14 io port: [a400, a40f]
PCI: 0000:01:09.0 reg 18 io port: [a800, a80f]
PCI: 0000:01:09.0 reg 1c io port: [ac00, ac3f]
pci 0000:01:09.0: supports D2
ICE1712 0000:01:09.0: PCI INT A -> Link[APC4] -> GSI 19 (level, low) ->
IRQ 19

I booted into single user mode each time and checked /proc/asound/cards
after each boot and then looked at dmesg.

Does this mean the card is toast?
What does the -12 mean?

What should I try next?

Kind regards,
Udo
