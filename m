From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [PATCH] ALSA: aoa: convert bus code to use dev_groups
Date: Fri, 29 May 2015 17:49:06 +0200
Message-ID: <55688A72.7000306@gmail.com>
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<s5hwpzs7qrz.wl-tiwai@suse.de>	<55671F56.6080402@gmail.com>	<s5hsiag7q0p.wl-tiwai@suse.de>	<55672980.4010904@gmail.com> <s5hh9qw7nlj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <s5hh9qw7nlj.wl-tiwai@suse.de>
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 28/05/2015 17:01, Takashi Iwai wrote:
>>> Also, it'd be better to move ATTRIBUTE_GROUPS(soundbus_dev) into
>>> soundbus/sysfs.c, and make it this global instead of
>>> soundbus_dev_attrs[].
>> Ok, I need to find a nice way to do that because ATTRIBUTE_GROUPS
>> declares the
>> structure as static.
>
> If it results in an ungly code, it's fine with the original code,
> too.  But, maybe with a comment indicating that xxx_dev_attrs[] is
> defined in xxx.c.
>
>
Since sound/aoa/soundbus/sysfs is small, a solution would be
to merge sound/aoa/soundbus/sysfs.c and sound/aoa/soundus/core.c.
Moreover all 172 other usages of the ATTRIBUTE_GROUPS macro
define the struct attribute *xxx_attrs[] in the same file
they assign the .dev_groups field.

I'm not sure about this change as it seems way more important than
adding a comment line as you suggested.

Should I send a patch merging these two files?

Quentin
