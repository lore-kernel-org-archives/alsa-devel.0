From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MOTU Midi Express XT driver
Date: Thu, 30 Jun 2011 18:05:07 +0200
Message-ID: <4E0C9EB3.6080802@ladisch.de>
References: <130e12ff39b.-3928454424886384200.-4172847127217991853@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2946C103965
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:05:10 +0200 (CEST)
In-Reply-To: <130e12ff39b.-3928454424886384200.-4172847127217991853@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torsten Schenk wrote:
> I'm currently trying to write a driver for the MOTU Midi Express XT.

Isn't that one of those insane devices that use isochronous transfers?

> The problem I have is that the device has same idVendor and idProduct
> as the MOTU FastLane Quad MIDI Interface (for which already a driver
> exists in snd-usbmidi).

Match on bDeviceSubClass.


Regards,
Clemens
