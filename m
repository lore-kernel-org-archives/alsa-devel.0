From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions on snd_kontrol_new
Date: Mon, 10 Nov 2008 09:56:05 +0100
Message-ID: <4917F725.5040401@ladisch.de>
References: <1226144189.6872.2.camel@thinkpad> <49157D12.8060305@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id CAD531037F2
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 09:55:55 +0100 (CET)
In-Reply-To: <49157D12.8060305@gmx.net>
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
> Could someone get me some insight into the snd_kontrol_new?
> I'm especially interested in the "private_value" and "index" field. At
> least in usb_mixer.c it seems to me like private_value is used as the
> index!? If that's the case, when should index be used and when
> private_value?

The index field is used when several controls have the same name.

The private_value field can be used by drivers for any purpose.

The functions for the Audigy 2 NX's LEDs store the LED number in the
private_value field so that the same function can be used for all three
LEDs without having to look at the control name.

> Is there any special convention for the string of "name" field?

linux/Documentation/sound/alsa/ControlNames.txt


HTH
Clemens
