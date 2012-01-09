From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH - ice1724 4/4] ALSA: ice1724 - Support for
	ooAoo SQ210a
Date: Mon, 09 Jan 2012 09:32:48 +0100
Message-ID: <4F0AA630.8000902@ivitera.com>
References: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>	<1325797318-16333-4-git-send-email-pavel.hofman@ivitera.com>
	<s5haa5ymu9b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id C59481039B9
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 09:32:49 +0100 (CET)
In-Reply-To: <s5haa5ymu9b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 8.1.2012 10:13, Takashi Iwai napsal(a):
> At Thu,  5 Jan 2012 22:01:58 +0100,
> pavel.hofman@ivitera.com wrote:
>>
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>
>> This card shares PCI ids with Chaintec AV710. Therefore, it will not be
>> detected automatically, it can only be activated by the module parameter
>> model=sq210a.
> 
> Hrm, that's bad.  Do you know any other way to identify the device?
> 

I am afraid I do not. There is no string ID in EEPROM contents (unlike
in some other cards). Perhaps the Chaintec EEPROM would offer a hint,
but I do not have the card on hand.

It is a very low-cost generic card, not many people know about it. Since
you applied the patch preventing kernel oops when the AV710 code was run
for this card, the autodetection just chooses a wrong card and it is
simple to reload the module with the model parameter. Plus I would not
be surprised if the other cards with different accessories produced by
that company shared all the same PCI ids and differed just in EEPROM
configs (most likely incorrect too :-) )

Thanks,

Pavel.
