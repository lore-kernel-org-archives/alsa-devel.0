From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: edirol m100fx
Date: Tue, 11 Mar 2008 08:42:50 +0100
Message-ID: <47D637FA.203@ladisch.de>
References: <369792.20649.qm@web39613.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C3B0B24673
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 08:41:20 +0100 (CET)
In-Reply-To: <369792.20649.qm@web39613.mail.mud.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: J Brumbagh <brumbach_j@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

J Brumbagh wrote:
> I saw a post on the soundcard list to contact you if I
> have a Roland/Edirol M-100fx 10 channel mixer.

Please show the output of "lsusb -v" for this device when
in advanced mode.

>                          On another note I also have
> an internal sound card lspci lists as an ALi
> Corporation M5451 PCI AC-Link Controller Audio Device
> (rev 02)"  This card has a headphone jack that seconds
> as a MiniTOSlink fiber optic jack.  The sound card
> works fine however the fiber optic doesn't work.

Please show the contents of /proc/asound/card0/ac97#0.


Regards,
Clemens
