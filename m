From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Subject: Re: [2.6.33-rc1] [SOUND] HDA: high cpu usage, noise
Date: Tue, 22 Dec 2009 16:42:18 +0100
Message-ID: <4B30E8DA.9040705@tremplin-utc.net>
References: <8db1092f0912200927y7cdab36ftd1f73d56cd89763f@mail.gmail.com>	<s5hmy1cpqo4.wl%tiwai@suse.de>	<8db1092f0912211012mcdd6639oaaf0bddc118e7d66@mail.gmail.com>	<4B2FC7B2.7000001@tremplin-utc.net>	<s5hk4wf1obu.wl%tiwai@suse.de>	<4B308E28.1090609@tremplin-utc.net>	<s5hk4wfz7tm.wl%tiwai@suse.de>	<4B30E2AD.8010709@tremplin-utc.net> <s5htyvjggp6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753599AbZLVPmX@vger.kernel.org>
In-Reply-To: <s5htyvjggp6.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, perex@perex.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

Op 22-12-09 16:40, Takashi Iwai schreef:
:
> 
> Do you have multiple HD-audio devices?  See /proc/asound/cards.
> If there are multiple, you need to pass a value for each.

# cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xe0624000 irq 17

So I guess there is only one device.

Eric
