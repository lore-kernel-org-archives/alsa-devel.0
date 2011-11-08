From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [regression] probably in mixer.c code
Date: Tue, 08 Nov 2011 13:39:38 +0100
Message-ID: <4EB9230A.1040607@fisher-privat.net>
References: <4EB8ED09.2090301@fisher-privat.net> <s5haa87gcka.wl%tiwai@suse.de>
	<4EB91192.8030906@fisher-privat.net> <s5hwrbag6fh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 30C661038E8
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 13:39:41 +0100 (CET)
In-Reply-To: <s5hwrbag6fh.wl%tiwai@suse.de>
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

Am 08.11.2011 13:11, schrieb Takashi Iwai:
> At Tue, 08 Nov 2011 12:25:06 +0100,
> Alexey Fisher wrote:
>>
>> Am 08.11.2011 10:59, schrieb Takashi Iwai:
>>> At Tue, 08 Nov 2011 09:49:13 +0100,
>>> Alexey Fisher wrote:
>>>>
>>>> Hallo all, Takashi,
>>>>
>>>> there is one regression in current linux main tree:
>>>>
>>>> cval->res quirks do not work any more. See usb/mixer.c:1150
>>>> Are there was some work in this area or may be some one bisected this
>>>> bug down?
>>>
>>> Are you referring to the device 046d:09a4, which sets the mixer range
>>> manually?  If yes, does the patch below work?
>>>
>>
>>
>> No, i referring to devices 046d:0991, 046d:081d, i don't have access to
>> 046d:09a4.
>>
>> This part is broken for me:
>>           case USB_ID(0x046d, 0x0991):
>>           /* Most audio usb devices lie about volume resolution.
>>            * Most Logitech webcams have res = 384.
>>            * Proboly there is some logitech magic behind this number --fishor
>>            */
>>                   if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
>>                           snd_printk(KERN_INFO
>>                                   "set resolution quirk: cval->res = 384\n");
>>                           cval->res = 384;
>>                   }
>>                   break;
>
> OK, so _what_ is actually broken?  Do you see the message but
> cval->res is overridden later?

yes.
