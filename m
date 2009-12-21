From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [2.6.33-rc1] [SOUND] HDA: high cpu usage, noise
Date: Mon, 21 Dec 2009 19:12:34 +0100
Message-ID: <8db1092f0912211012mcdd6639oaaf0bddc118e7d66@mail.gmail.com>
References: <8db1092f0912200927y7cdab36ftd1f73d56cd89763f@mail.gmail.com>
	 <s5hmy1cpqo4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755862AbZLUSMj@vger.kernel.org>
In-Reply-To: <s5hmy1cpqo4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

2009/12/21 Takashi Iwai <tiwai@suse.de>:
> At Sun, 20 Dec 2009 18:27:45 +0100,
> Maciej Rutecki wrote:
>>
>> Hi
>>
>> Affected kernel: 2.6.33-rc1
>> Last known good: 2.6.32
>
> The only fundamental change, AFAIK, is the use of MSI as default.
> Could you try to add enable_msi=0 option to snd-hda-intel?
>

root@gumis:/# cat /sys/module/snd_hda_intel/parameters/enable_msi
0

Still the same:
ps aux:

root      1117 27.4  0.0      0     0 ?        S    19:00   2:05 [hd-audio0]

I also notice short sound during booting system, when sound modules is
loading.  I can try bisection, but in next week; already I don't have
to much time.

Regards
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
