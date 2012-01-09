From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - ice1724 4/4] ALSA: ice1724 - Support for
 ooAoo SQ210a
Date: Mon, 09 Jan 2012 10:24:51 +0100
Message-ID: <4F0AB263.1040003@ladisch.de>
References: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>	<1325797318-16333-4-git-send-email-pavel.hofman@ivitera.com>
	<s5haa5ymu9b.wl%tiwai@suse.de> <4F0AA630.8000902@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AF5211039C4
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 10:23:19 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 13A9121E9D
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 04:23:18 -0500 (EST)
In-Reply-To: <4F0AA630.8000902@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Dne 8.1.2012 10:13, Takashi Iwai napsal(a):
>> pavel.hofman@ivitera.com wrote:
>>> This card shares PCI ids with Chaintec AV710. Therefore, it will not be
>>> detected automatically, it can only be activated by the module parameter
>>> model=sq210a.
>>
>> Hrm, that's bad.  Do you know any other way to identify the device?
>
> I am afraid I do not.

There is already a conflict with the AV710; it appears all three vendors
use some default ID.

> Plus I would not be surprised if the other cards with different
> accessories produced by that company shared all the same PCI ids and
> differed just in EEPROM configs (most likely incorrect too :-) )

Their CMI8788-based cards implement only features that are a subset of
those supported by the generic Windows driver.  (I guess they ship
an .ini file that disables things like 7.1 output on a stereo card (thus
breaking other models with the same ID), but it's possible that they
just don't bother.)


Pavel, please don't forget to update the sound card matrix:
http://www.alsa-project.org/main/index.php/Matrix:Vendor-%E5%82%B2%E7%8E%8B


Regards,
Clemens
