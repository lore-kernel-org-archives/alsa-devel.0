From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] SoC: intel: byt: Introduce new custom IN2
 map
Date: Tue, 21 Nov 2017 09:12:16 -0600
Message-ID: <b527fea6-ab27-1d13-a465-954659eec011@linux.intel.com>
References: <20171018164957.2270-1-carlo@caione.org>
 <b09a704c-bb3e-32c4-afcb-d11379b6a3b9@linux.intel.com>
 <CAOQ7t2YFfkCEkgoGPspr8Kvuomz-eeprqC6NJXiUhDApFqbduA@mail.gmail.com>
 <CAOQ7t2Y--RJcV5bcnsWwuc7G6tc_EsgCBuNqELD2CE1zFJcCdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOQ7t2Y--RJcV5bcnsWwuc7G6tc_EsgCBuNqELD2CE1zFJcCdQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 11/21/17 3:30 AM, Carlo Caione wrote:
> On Thu, Nov 16, 2017 at 1:53 PM, Carlo Caione <carlo@caione.org> wrote:
>> On Wed, Oct 18, 2017 at 7:05 PM, Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.intel.com> wrote:
>>> On 10/18/17 11:49 AM, Carlo Caione wrote:
>>>>
>>>> From: Carlo Caione <carlo@endlessm.com>
>>>>
>>>> Introduce a new custom dapm routes map to quirk platforms with the
>>>> internal mic connected to IN2P.
>>>
>>>
>>> LGTM. If we start getting more quirks for this codec, we should think of
>>> adding a module parameters to select them from the command line or with
>>> modprobe (as done in other machine drivers).
>>
>> Hey Pierre,
>> I'm currently working on a laptop (always with the rt5651 codec)
>> having two separate internal mics (on IN1P and IN2P) and the headset
>> on IN3P. I was thinking how to describe this situation in the current
>> driver without having to add all the 6 different configuration as
>> quirks. Any suggestion?


The microphone configurations are not handled with a mask but an enum 
and the BYT_RT5651_MAP() macro. You can just add a new configuration 
such at BYT_RT5651_IN1_IN2 which uses the analog mics on those two and 
implicitly use IN3 for the headset. I don't see the point of handling 
all possible permutations at this point.
