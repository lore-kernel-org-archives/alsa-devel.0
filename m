From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] USB-Audio: Disable "Logitech USB Headset"
 iec958 device
Date: Thu, 08 Mar 2012 16:47:31 +0100
Message-ID: <4F58D493.6050703@ladisch.de>
References: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A1B56243F4
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 16:44:16 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 048A9212CB
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 10:44:14 -0500 (EST)
In-Reply-To: <1331115784-3541-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: clemens@ladish.de, alsa-devel@alsa-project.org, 940145@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> Because Logitech USB Headsets do not have any digital devices,
> prevent them from being opened. This simplifies probing the
> device in PulseAudio.
>
> --- a/src/conf/cards/USB-Audio.conf
> +++ b/src/conf/cards/USB-Audio.conf
> @@ -36,6 +36,8 @@ USB-Audio.pcm.surround40_type {
>  # number for the iec958 device can be changed here.
>  USB-Audio.pcm.iec958_device {
>  	# "NoiseBlaster 3000" 42
> +	# Make sure we can't open this device digitally, because it does not exist
> +	"Logitech USB Headset" 999
>  }

This introduces a blacklist of devices that do not have digital outputs.
There are lot of other such devices that need such entries to make PA
work better, but at the moment, the only alternative would be a whitelist
of devices with digital outputs, which would have exactly the same
maintenance problems.

As long as there is no mechanism for .conf files to find out whether
a USB device actually has digital outputs, there's no better way to
solve the problem.


Regards,
Clemens
