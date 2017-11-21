From: Carlo Caione <carlo@caione.org>
Subject: Re: [alsa-devel] [PATCH] SoC: intel: byt: Introduce new custom IN2 map
Date: Tue, 21 Nov 2017 09:30:02 +0000
Message-ID: <CAOQ7t2Y--RJcV5bcnsWwuc7G6tc_EsgCBuNqELD2CE1zFJcCdQ@mail.gmail.com>
References: <20171018164957.2270-1-carlo@caione.org> <b09a704c-bb3e-32c4-afcb-d11379b6a3b9@linux.intel.com>
 <CAOQ7t2YFfkCEkgoGPspr8Kvuomz-eeprqC6NJXiUhDApFqbduA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOQ7t2YFfkCEkgoGPspr8Kvuomz-eeprqC6NJXiUhDApFqbduA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux Upstreaming Team <linux@endlessm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, open list <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 1:53 PM, Carlo Caione <carlo@caione.org> wrote:
> On Wed, Oct 18, 2017 at 7:05 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 10/18/17 11:49 AM, Carlo Caione wrote:
>>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> Introduce a new custom dapm routes map to quirk platforms with the
>>> internal mic connected to IN2P.
>>
>>
>> LGTM. If we start getting more quirks for this codec, we should think of
>> adding a module parameters to select them from the command line or with
>> modprobe (as done in other machine drivers).
>
> Hey Pierre,
> I'm currently working on a laptop (always with the rt5651 codec)
> having two separate internal mics (on IN1P and IN2P) and the headset
> on IN3P. I was thinking how to describe this situation in the current
> driver without having to add all the 6 different configuration as
> quirks. Any suggestion?

gentle ping on this question.

cheers,

-- 
Carlo Caione
