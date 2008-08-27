From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RESEND] sound: make OSS sound core optional
Date: Wed, 27 Aug 2008 11:37:44 +0200
Message-ID: <48B52068.2090502@kernel.org>
References: <48B50E17.4020106@kernel.org> <s5hprnubz89.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755272AbYH0JjW@vger.kernel.org>
In-Reply-To: <s5hprnubz89.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hello,

Takashi Iwai wrote:
>> +config SOUND_OSS_CORE
>> +	bool
>> +	default n
>> +
>>  source "sound/oss/dmasound/Kconfig"
> 
> This seems missing from the scope.
> But, I think this should be rather in the block "if SOUND_PRIME" below.

SOUND_OSS_CORE should be turned on if ALSA OSS emul is turned on or
arch-um hostsound is turned on, both of which can be enabled regardless
of SOUND_PRIME, no?

>> --- work.orig/sound/sound_core.c
>> +++ work/sound/sound_core.c
> (snip)
>> +MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
> 
> This alias should be in #ifdef CONFIG_SOUND_OSS_CORE.
> The module doesn't provide that major without CONFIG_SOUND_OSS_CORE.

Ah.. right.  Moving.

Thanks.

-- 
tejun
