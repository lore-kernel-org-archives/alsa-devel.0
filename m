From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] usbmidi.c: Call usb_autopm functions from
 rawmidi open/close callbacks
Date: Tue, 18 Mar 2008 15:16:12 +0100
Message-ID: <47DFCEAC.1020004@ladisch.de>
References: <200803181505.46464.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AAD1E2442E
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 15:16:16 +0100 (CET)
In-Reply-To: <200803181505.46464.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> Lets "usb auto suspend" work for devices that set their
> usb_driver::supports_autosuspend to 1.

... as long as there are no MIDI input ports.

I'm planning to apply these patches:
http://thread.gmane.org/gmane.linux.usb.general/1002/focus=1414


Regards,
Clemens
