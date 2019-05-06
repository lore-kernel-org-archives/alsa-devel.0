From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers
 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
Date: Mon, 6 May 2019 17:40:21 +0200
Message-ID: <b9ea51f6-29fb-5ae8-607b-a047eba4bac0@redhat.com>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <20190504151652.5213-4-user@elitebook-localhost>
 <s5ha7g1l4oq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha7g1l4oq.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Nariman <narimantos@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jordy Ubink <jordyubink@hotmail.nl>, broonie@kernel.org, liam.r.girdwood@linux.intel.com, pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi,

On 05-05-19 09:51, Takashi Iwai wrote:
> On Sat, 04 May 2019 17:16:52 +0200,
> Nariman wrote:
>>
>> From: Jordy Ubink <jordyubink@hotmail.nl>
>>
>> The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.
>>
>> Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
> 
> If you submit a patch, please give your own sign-off as well as the
> author's one, even if the patch is not written by you.  This is a
> legal requirement.

Sorry, that is my bad, Nariman and the author authors of the patches
are a group of students doing some kernel work for me and this is
a warm-up assignment for them to get used to the kernel development
process.

I forgot to point out to Nariman that since he is sending
out the entire series for all 4 of them, he needs to add his
S-o-b.

Regards,

Hans
