From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] ASoC: Add a sanity check before using dai driver name
Date: Wed, 23 Aug 2017 07:42:55 +0800
Message-ID: <599CC17F.90806@rock-chips.com>
References: <20170822144512.12976-1-jeffy.chen@rock-chips.com> <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170822161756.5h6smkjz6kkvl5i7@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, dolinux.peng@gmail.com, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

hi Mark,

On 08/23/2017 12:17 AM, Mark Brown wrote:
> On Tue, Aug 22, 2017 at 10:45:12PM +0800, Jeffy Chen wrote:
>
>> -			return dai;
>> +			if (!dlc->dai_name)
>> +				return dai;
>> +			if (!strcmp(dai->name, dlc->dai_name))
>> +				return dai;
>
> You want (dlc->dai_name && !strcmp(dai->name, dlc->dai_name)) for this
> to be equivalent don't you?
i think the original check is allowing NULL dlc dai_name to be a match...
so we basically did:
reject when dlc dai_name is valid, but not match the dai name

and my patch is:
accept when dlc dai_name is invalid
accept when match dai name
accept when match dai driver name(only when it is valid)

so it's a "if (a && b) reject" to "if (!a || !b) accept" case..

>
>> +			if (dai->driver->name &&
>> +			    !strcmp(dai->driver->name, dlc->dai_name))
>
