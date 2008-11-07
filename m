From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hints for usb audio patch
Date: Fri, 07 Nov 2008 15:20:01 +0100
Message-ID: <49144E91.3030802@ladisch.de>
References: <49117E67.8000100@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id F248C24475
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 15:19:50 +0100 (CET)
In-Reply-To: <49117E67.8000100@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LCID Fire <lcid-fire@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

LCID Fire wrote:
> 2. Should one rather set ignore_ctl_error to 1 (which I currently do) or
> sort the errors out by adding a handling for a specific device?

As long as it works fine with ignore_ctl_error, there's no reason to
add more code.

> 3. For the switch to active I need an interrupt message for which I
> implemented snd_usb_interrupt_trans since I did not find any other
> convenience function to do this.

Well, I'd need to see the code to evaluate your solution ...  :-)


Regards,
Clemens
