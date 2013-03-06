From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [PATCH] Make snd_BUG_ON() always evaluate and return
 the conditional expression.
Date: Wed, 06 Mar 2013 14:49:28 +0100
Message-ID: <51374968.4070805@canonical.com>
References: <1362434579-7733-1-git-send-email-christine.spang@oracle.com> <s5h8v62gqt0.wl%tiwai@suse.de> <51365862.9050401@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51365862.9050401@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christine Spang <christine.spang@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sasha.levin@oracle.com>, alsa-devel@alsa-project.org, Jamie Iles <jamie.iles@oracle.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2013-03-05 21:41, Christine Spang skrev:
> On 03/05/2013 04:05 AM, Takashi Iwai wrote:
>> At Mon,  4 Mar 2013 17:02:59 -0500,
>> Christine Spang wrote:
>>> Having snd_BUG_ON() only evaluate its conditional when CONFIG_SND_DEBUG
>>> is set leads to frequent bugs, since other similar macros in the kernel
>>> have different behavior. Let's make snd_BUG_ON() act like those macros
>>> so it will stop being accidentally misused.
>>>
>>> Signed-off-by: Christine Spang <christine.spang@oracle.com>
>> Sounds reasonable.  The dependency on CONFIG_SND_DEBUG was for
>> allowing more optimization, but since we use this for more places than
>> expected, this change would be safer indeed.
>>
>> If no one has objection, I'll apply it for 3.10 kernel.

If snd_BUG_ON now works like WARN_ON rather than BUG_ON (at least it 
does with this change, if I understand things right), maybe we should 
rename it to snd_WARN_ON for consistency?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
