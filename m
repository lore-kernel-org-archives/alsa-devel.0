From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V2 01/10] ASoC: amd: dma config parameters changes
Date: Mon, 7 May 2018 15:52:33 +0530
Message-ID: <b002a891-a098-9a61-b105-71519ddb05dd@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
 <e53cd47f-ac63-93ca-9751-f9185d94d17a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e53cd47f-ac63-93ca-9751-f9185d94d17a@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Jason Clinton <jclinton@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org
List-Id: alsa-devel@alsa-project.org



On Monday 07 May 2018 11:57 AM, Mukunda,Vijendar wrote:
> 
> 
> On Wednesday 02 May 2018 02:19 AM, Vijendar Mukunda wrote:
>> Added dma configuration parameters to rtd structure.
>> Moved dma configuration parameters initialization to
>> hw_params callback.
>> Removed hard coding in prepare and trigger callbacks.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>> v1->v2 : Fixed capture stream wrong channel assignment
>>      added comments in dma trigger api
>>   sound/soc/amd/acp-pcm-dma.c | 103 
>> ++++++++++++++++++--------------------------
>>   sound/soc/amd/acp.h         |   5 +++
>>   2 files changed, 48 insertions(+), 60 deletions(-)
> 
> Hi Mark,
> 
> In this series, patches 01/10 to 09/10 are good to go from Dan, could 
> you please review and merge them.
> 
> For 10/10 please let us know your thoughts on it, discussion reference:
> https://lkml.org/lkml/2018/5/4/23
> 
> Thanks,
> Vijendar


Hi Mark,

After comment from Dan on 10/10 , re-spinning the patch series by
adding Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks,
Vijendar
