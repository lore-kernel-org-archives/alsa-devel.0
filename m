From: rmgls@free.fr
Subject: Re: rme multiface I=>pccard error -12
Date: Tue, 04 Dec 2007 11:23:22 +0100
Message-ID: <20071204102324.AA2C13227FC@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A71A243B3
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 11:23:26 +0100 (CET)
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


> At Fri, 30 Nov 2007 15:11:08 +0100,
> rmgls@free.fr wrote:
>> 
>> 
>> Hello,
>> 
>> on a laptop the old multiface I with a pccard (1) doesn't attach.
>> acore returns error -12.
>> 
>>       details:
>> dmesg:
>> pccard: CardBus card inserted into slot 0
>> ALSA /root/alsa-driver-hg20071129/acore/init.c:174: cannot find the slot for index 0 (range 0-0), error: -16

> Check /proc/asound/cards.  The index 0 is likely already used by
> another device.  Since the recent distro loads the sound drivers
> automatically via udev, you'll have to set index for all drivers
> properly.

> If it's snd-hda-intel, add the option like below:

> options snd-hda-intel index=1


> Takashi

Hello Takashi,

thanks for this info, and sorry for the noise.
all worlks fine now.

Best regards

rmgls@free.fr
