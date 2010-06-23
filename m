From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.35-rc3 E-MU 0404 USB problem
Date: Wed, 23 Jun 2010 14:45:19 +0200
Message-ID: <4C2201DF.9050500@ladisch.de>
References: <4C20B364.9060405@blueyonder.co.uk>
	<20100622131102.GA18432@kroah.com>
	<20100622133434.GZ2698@buzzloop.caiaq.de>
	<4C21E875.20200@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.42]) by alsa0.perex.cz (Postfix) with ESMTP id 88DC11037F5
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 14:45:24 +0200 (CEST)
In-Reply-To: <4C21E875.20200@blueyonder.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sboyce@blueyonder.co.uk, Daniel Mack <daniel@caiaq.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>>> Sid Boyce wrote:
>>>> Transmit fails,

What exactly fails?

>>>> dmesg output with 48K sample rate set is:-
>>>> ALSA sound/usb/clock.c:214: 6:2:3: endpoint lacks sample rate attribute bit, cannot set.

There are many devices that have only one sample rate or that have one
sample rate per alternate setting.  This doesn't deserve a message, much
less a warning.


Regards,
Clemens
