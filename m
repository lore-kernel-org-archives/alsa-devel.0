From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Huawei K3715 UMTS stick and alsa
Date: Tue, 28 Jul 2009 09:36:30 +0200
Message-ID: <4A6EAA7E.4090207@ladisch.de>
References: <20090726224300.GA26953@titan.makhutov-it.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AAC68245BA
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jul 2009 09:36:15 +0200 (CEST)
In-Reply-To: <20090726224300.GA26953@titan.makhutov-it.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Artem Makhutov <artem@makhutov.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Artem Makhutov wrote:
> i am wondering if it is possible to write a quirk in usbquirks.h for a Huawei
> K3715 UMTS stick to make the audio interfaces available in linux.

What kind of audio does this UMTS stick have?

> This two interfaces are used for audio (I have sniffed in Windows):
> 
> bEndpointAddress     0x83  EP 3 IN
> bEndpointAddress     0x02  EP 2 OUT

The lsusb output shows that these are bulk endpoints.  The snd-usb-audio
driver is designed for isochronous endpoints; a simple quirk would not
suffice.

> The payload of this interfaces is 320 bytes.

How many bytes per second?


Best regards,
Clemens
