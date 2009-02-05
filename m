From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tascam US-1641 Firmware File
Date: Thu, 05 Feb 2009 13:08:25 +0100
Message-ID: <498AD6B9.4070903@ladisch.de>
References: <58f7a09c0902021427i3eaa9955nf862b1ef282569ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 7F89E1037FD
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 13:08:30 +0100 (CET)
In-Reply-To: <58f7a09c0902021427i3eaa9955nf862b1ef282569ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Donnie Menig <soundprizm@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Donnie Menig wrote:
> I have the Tascam US-1641 firmware now... I'm pretty sure I did everything
> right, but I keep getting the "can't modify CPUCS: Broken pipe" or "unable
> to open for input." error.

You didn't tell what you're doing with the firmware, or how you're doing
it, but I guess you are trying to download it.

"Broken pipe" means error code EPIPE, which means, according to
linux/Documentation/usb/error-codes.txt, "endpoint is stalled", which
means that the device did not like what you did to it.

The "CPUCS" indicates that you're trying to use the EZ-USB download
protocol; however, the firmware file is too big for that, i.e., your
device is based on some other chipset.


Best regards,
Clemens
