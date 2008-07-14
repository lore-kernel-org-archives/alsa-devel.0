From: =?ISO-8859-1?Q?Maximilian_G=FCntner?= <beomuex@gmx.de>
Subject: Re: SB0880 X-Fi Titanium Fatal1ty Pro (with codecgraph)
Date: Mon, 14 Jul 2008 15:59:53 +0200
Message-ID: <487B5BD9.7090307@gmx.de>
References: <1215985902.4196.11.camel@localhost>
	<s5h4p6rw5zu.wl%tiwai@suse.de>	<487B5344.7020709@gmx.de>
	<s5hskubq72c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1B2222437E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 15:59:42 +0200 (CEST)
In-Reply-To: <s5hskubq72c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>> Does this hack only work with the  X-Fi Titanium Fatal1ty Pro, or does 
>> it include support for all X-Fi based cards from Creative Labs?
>>     
>
> It's only for X-Fi with HD-audio compatibility.  It's not for native
> Emu20k stuff.
>   
HD-audio means what exactly?
How can i see whether a card has this feature or not?
The cards you mentioned have all 64 MB X-RAM, mine has only 2 MB.
Is this a indication of missing HD-Audio support ?

> I have got a Creative X-Fi Extreme Music, that gets infact recognized by 
> my system but modprobing the patched source (modprobe snd-hda-intel, i 
> hope this is the right one) does not work.
> Here the lspci if this helps:
>   
>
> Check "lspci -n".  So far, 1102:0009 and 1102:000b are known to be
> HD-audio compatible.
>
>   
This is lspci -nn
01:02.0 Multimedia audio controller [0401]: Creative Labs SB X-Fi 
[1102:0005]

-- beomuex
