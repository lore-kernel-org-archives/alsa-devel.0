From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [2.6.33-rc1] [SOUND] HDA: high cpu usage, noise
Date: Wed, 23 Dec 2009 15:27:08 +0100
Message-ID: <4B3228BC.1080204@tremplin-utc.net>
References: <8db1092f0912200927y7cdab36ftd1f73d56cd89763f@mail.gmail.com>	<s5hmy1cpqo4.wl%tiwai@suse.de>	<8db1092f0912211012mcdd6639oaaf0bddc118e7d66@mail.gmail.com>	<4B2FC7B2.7000001@tremplin-utc.net>	<s5hk4wf1obu.wl%tiwai@suse.de>	<4B308E28.1090609@tremplin-utc.net> <s5hk4wfz7tm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756031AbZLWO1N@vger.kernel.org>
In-Reply-To: <s5hk4wfz7tm.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

Op 22-12-09 10:17, Takashi Iwai schreef:
:
>>> Another thing to try is to replace the whole HD-audio stack with the
>>> last working one (was it 2.6.32?), and check whether it works with
>>> 2.6.32 core.
>> Could you give more details on how to do this?
>> Does it consist in taking the sound/ directory of 2.6.32 and copying it
>> over 2.6.33-rc1 ? Or less files?
> 
> I'd try first only sound/pci/hda/* files.
> 
Brute-force reverting these files to the version of 2.6.32.2 does fix
the problem.

When I find time, I'll try to git bisect on this particular directory...
but anyone willing to try to beat me at this is welcome, as Christmas is
going to keep me rather busy ;-)

Eric
