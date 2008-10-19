From: James Courtier-Dutton <James@superbug.co.uk>
Subject: snd-xfi programming, some guidelines.
Date: Sun, 19 Oct 2008 10:20:51 +0100
Message-ID: <48FAFBF3.4070106@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id F181E2436E
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 11:21:10 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.69)
	id 1KrUSz-00030q-Ms
	for alsa-devel@alsa-project.org; Sun, 19 Oct 2008 09:20:53 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have not had time to review the current work on the snd-xfi, but I
have provided input if I think it would be useful.

I have one more piece of information that might help.
The xfi has two ways to talk to all the registers.
1) ioports using ioport pointer offset write method as familiar with
older emu10k1 cards.
2) iomem using simple memory writes.

The same registers on the xfi card can be accessed via both methods.
There is some guidance as to when to use each. I.e. Do not use iomem for
everything.
There are some registers that take longer to write to than others.
Unfortunately, the datasheet does not tell me which these slow are, so
trial and error might be required.
Now, if one uses the iomem to write to these registers that take a long
time to update, it ties up the entire PCI bus for the entire duration,
so this is not a good idea. So, the recommendation is that one should
use ioports to access these slow registers as this will not block the
PCI bus.

I suggest putting a timer round each ioport and iomem write to find the
slow ones.

Kind Regards

James
