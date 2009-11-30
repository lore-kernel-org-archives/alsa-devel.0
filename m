From: "Andrey A. Porodko" <andrey.porodko@gmail.com>
Subject: Re: Sound support for Neuros OSD2 Davinci based board.
Date: Mon, 30 Nov 2009 11:47:52 +0500
Message-ID: <4B136A98.4010400@gmail.com>
References: <4B0E7D5E.3080906@chelcom.ru> <20091127164733.GC11913@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753571AbZK3Grv@vger.kernel.org>
In-Reply-To: <20091127164733.GC11913@rakim.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Chaithrika U S <chaithrika@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>, David Brownell <dbrownell@users.sourceforge.net>, Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Nov 26, 2009 at 06:06:38PM +0500, A. Porodko wrote:
>   
>> Hello,
>>
>> Here is a patch for Neuros OSD2 Davinci (DM6446) based board sound support.
>> Patch made against 2.6.32-rc6 kernel.
>>     
>
> This doesn't apply against current ASoC.  Could you please regenerate
> against this branch:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33
>
>   
Hi Mark,

Are you sure you have the latest davinci soc support in your tree?
Mine file davinci_evm.c is 7.5k size, in your

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

repo your is 5.5k. Quick glance shows that in your repo davinci support
lacks of da830_evm support.
I'm confused which one is I have to use and apply patch to?

-- 
Best regards
Andrey A. Porodko
 
