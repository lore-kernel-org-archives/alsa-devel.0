From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai driver name
Date: Thu, 24 Aug 2017 18:44:40 +0800
Message-ID: <599EAE18.2030401@rock-chips.com>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com> <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk> <599CC17F.90806@rock-chips.com> <20170823110628.xergjdexrmxyqrza@sirena.org.uk> <599E4826.1060607@rock-chips.com> <20170824101826.htrevrhhgez2pgoe@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824101826.htrevrhhgez2pgoe@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, dolinux.peng@gmail.com, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

hi Mark,

On 08/24/2017 06:18 PM, Mark Brown wrote:
> On Thu, Aug 24, 2017 at 11:29:42AM +0800, jeffy wrote:
>
>> and i was trying to do something like:
>> if (dlc->dai_name && strcmp(dai->name, dlc->dai_name)
>>      && (!dai->driver->name || strcmp(dai->driver->name, dlc->dai_name)))
>>     continue;
>
>> which is add an accept case for: dai driver name is valid and matches the
>> dai name we are looking for...
>
> Writing it as one if statement would at least be clearer.  I can't
> remember the patch you proposed at this point but the above looks
> plausible.
right, i've already post a v3 for that ;)
>
