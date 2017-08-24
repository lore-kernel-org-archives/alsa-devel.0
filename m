From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai driver name
Date: Thu, 24 Aug 2017 11:29:42 +0800
Message-ID: <599E4826.1060607@rock-chips.com>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com> <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk> <599CC17F.90806@rock-chips.com> <20170823110628.xergjdexrmxyqrza@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823110628.xergjdexrmxyqrza@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, dolinux.peng@gmail.com, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/23/2017 07:06 PM, Mark Brown wrote:
> On Wed, Aug 23, 2017 at 07:42:55AM +0800, jeffy wrote:
>
>> >i think the original check is allowing NULL dlc dai_name to be a match...
>> >so we basically did:
>> >reject when dlc dai_name is valid, but not match the dai name
> So it is, but this still looks like the wrong thing - it'll match on an
> empty DAI name over an explicit match on the driver name which seems
> like it's the wrong way round.
>
sorry, i don't know much about asoc, so i just trying to keep the 
original conditions and add the new one on it :)

the original one is:
if (dlc->dai_name && strcmp(dai->name, dlc->dai_name))
    continue;

and i was trying to do something like:
if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
     && (!dai->driver->name || strcmp(dai->driver->name, dlc->dai_name)))
    continue;

which is add an accept case for: dai driver name is valid and matches 
the dai name we are looking for...
