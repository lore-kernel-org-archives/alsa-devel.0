From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Thu, 14 May 2015 21:38:55 +0200
Message-ID: <5554F9CF.3020601@metafoo.de>
References: <554E8634.2010008@maciej.szmigiero.name> <20150512175807.GL3066@sirena.org.uk> <5553BAB4.3040209@maciej.szmigiero.name> <20150514175351.GQ2761@sirena.org.uk> <5554ED71.4040608@metafoo.de> <20150514191031.GS2761@sirena.org.uk> <5554F65F.7090004@metafoo.de> <20150514192847.GV2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514192847.GV2761@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/14/2015 09:28 PM, Mark Brown wrote:
> On Thu, May 14, 2015 at 09:24:15PM +0200, Lars-Peter Clausen wrote:
>> On 05/14/2015 09:10 PM, Mark Brown wrote:
>
>>> Does the select from SND_SOC_AC97_BUS actually happen if it is selected
>>> by SND_SOC_ALL_CODECS?  That's the issue, if it works now it's a
>>> relatively recent thing.
>
>> I'm not sure I fully understand what you mean.
>
>> The Kconfig entry for the CODEC has no 'depends on'. It does a 'select
>> SND_SOC_AC97_BUS', which means all built time dependencies are pulled in
>> this way. So if SND_SOC_ALL_CODECS selects the CODEC unconditionally that
>> should work fine, since no dependencies are bypassed.
>
> No, it's not just dependencies but also selects that get ignored (or
> used to anyway like I say) - a select just forces the symbol on.
>

select forces a symbol on regardless of whether its dependencies are met or 
not. But for any symbol that is on, no matter whether it was manually 
selected or selected by a 'select' from another symbol, any symbols selected 
by that symbol will be turned on. It's been that way as long as I can remember.
