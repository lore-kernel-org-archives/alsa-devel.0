From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 2/2] ALSA: hdspm - Provide unique driver id
 based on card serial
Date: Tue, 10 Jan 2012 20:53:23 +0100
Message-ID: <4F0C9733.8060300@drcomp.erfurt.thur.de>
References: <1325683877-16783-1-git-send-email-adi@drcomp.erfurt.thur.de>	<1325683877-16783-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hipkmkyy7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [89.163.167.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C711103AF9
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 20:53:34 +0100 (CET)
In-Reply-To: <s5hipkmkyy7.wl%tiwai@suse.de>
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

On 01/08/2012 04:15 PM, Takashi Iwai wrote:

Hi!

>> Before, /proc/asound looked like this:
>>
>>   2 [Default        ]: HDSPM - RME RayDAT_f1cd85
>>                        RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18
>>
>>
>>   2 [HDSPM_f1cd85   ]: HDSPM - RME RayDAT_f1cd85
>>                        RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18
> This can't be applied as is, unfortunately.
> This would break when user passes the card id string via option.

Thanks for spotting, I wasn't even aware of this option. :-/

> Also, if multiple boards have the same serial number (who can trust
> the hardware? :), it gets -EBUSY at registration.

Is that true? I don't have two RME cards here, but I've simply
duplicated a string from my mainboard chip. snd_card_register() was just
fine:

$ cat /proc/asound/cards
  0 [PCH            ]: HDA-Intel - HDA Intel PCH
                       HDA Intel PCH at 0xf7420000 irq 55
  1 [NVidia         ]: HDA-Intel - HDA NVidia
                       HDA NVidia at 0xf7080000 irq 17
  2 [PCH            ]: HDSPM - RME RayDAT_f1cd85
                       RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18


Note that snd_card_create() is still called without any serial number
magic, so card->id will first be set to "Default", "Default_1" and so on
and only later modified before calling snd_card_register().

Since I don't see anything in snd_card_register() that could possibly
fail, it would at least still work. Anyway, I'm now using
snd_card_set_id(), and this function claims to check for duplicates. ;)


> And, MADIface will have no serial number, so it'll look strange.

The code in question is limited to "if (!MADIface)", so no problem.


> (Also the string with "%s_%04x" would be better, IMO.)

I chose %06x, since the serial is masked with 0xFFFFFF.


> For these, I'd suggest the following changes:
> - check whether serial is non-zero

That's actually 0xFFFFFF in case there is no serial. All PCI revisions
behave like that.


> - modify sound core registration part to re-generate the id string
>    with suffix whenever conflicted, only not when the automated id
>    string generation via card->id = NULL.

I did not address this. Firstly, because snd_card_register() worked well
even in case of colliding card->ids, and secondly, because
snd_card_set_id would take care now to make it unique.


I'll repost the patch in a second.
