From: Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: ice1712 error
Date: Sat, 20 Dec 2008 17:22:04 +0100
Message-ID: <494D1BAC.6080608@xs4all.nl>
References: <494BC00A.9080202@xs4all.nl>	<s5hocz8uq0t.wl%tiwai@suse.de>	<494BC52B.8020605@xs4all.nl>	<s5hljucuouu.wl%tiwai@suse.de>	<494BCA18.3080508@xs4all.nl>	<s5h8wqcumjn.wl%tiwai@suse.de>	<494BD77D.4000401@xs4all.nl>	<s5hr643cked.wl%tiwai@suse.de>	<494CD2DD.3040703@xs4all.nl>	<494CEB68.1050702@xs4all.nl>
	<s5hzliqua66.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr19.xs4all.nl (smtp-vbr19.xs4all.nl [194.109.24.39])
	by alsa0.perex.cz (Postfix) with ESMTP id D6CC11037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 17:22:05 +0100 (CET)
In-Reply-To: <s5hzliqua66.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>> It appears that in init.c, in snd_card_new this part of code is causing 
>> the error:
>>
>>         else if (idx < snd_ecards_limit) {
>>                  if (snd_cards_lock & (1 << idx))
>>                          err = -EBUSY;   /* invalid */
>>                  printk(KERN_WARNING "busy............\n"); /*my debug */
>>          }
>>
>> So it is my card?
>> Repeatedly rmmodding and modprobing snd_ice1712 now only gives me -12
>>
>> Please advise.
> 
> It means that the given slot is already occupied, or so.  Unlikely a
> driver error but a user-setup problem.

Ok, that is good news!

> Check index options of all sound cards.  For example, try to remove
> index options once, and let the system load all devices.

I #'ed out all index lines in /etc/modprobe.conf and then the card 
immediately worked when I used rmmopd/modprobe.

> In general, using slots option of snd module is recommended.  Read
> ALSA-Configuration.txt for details.

Will have a look and give it a try.
Thanks!

Udo
