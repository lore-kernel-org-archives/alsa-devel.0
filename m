From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions about devices supported by alsa
Date: Mon, 11 Feb 2008 11:45:38 +0100
Message-ID: <47B02752.5020803@ladisch.de>
References: <47ADFFF2.4050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 05E502417B
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 11:43:51 +0100 (CET)
In-Reply-To: <47ADFFF2.4050803@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergio Atzori <sergioatzori@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sergio Atzori wrote:
> 2) Miditech I2 control-37 (http://www.miditech.de/produktee_i2.htm):
> beatiful usb-keyboard, not mentioned in Linux-USB device site, it does
> not work in linux...I think the kernel configure it well (as
> snd-usb-audio device) but I can't see it in Jack midi connections..

Does it appear in the output of "amidi -l"?
Does it appear in the output of "aplaymidi -l"?


Regards,
Clemens
