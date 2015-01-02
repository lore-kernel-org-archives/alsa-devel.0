From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH] ALSA: ASoC: soc-compress.c: fix NULL dereference
Date: Fri, 2 Jan 2015 09:07:32 +0000
Message-ID: <54A65FD4.10600@imgtec.com>
References: <1419325767-30602-1-git-send-email-qais.yousef@imgtec.com> <20141229161303.GU17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141229161303.GU17800@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/29/2014 04:13 PM, Mark Brown wrote:
> On Tue, Dec 23, 2014 at 09:09:27AM +0000, Qais Yousef wrote:
>> In soc_new_compress() when rtd->dai_link->daynmic is set, we create the pcm
>> substreams with this call:
>>
>>     ret = snd_pcm_new_internal(rtd->card->snd_card, new_name, num,
>>                                     1, 0, &be_pcm);
>>
>> which passes 0 as capture_count leading to
>>
>>     be_pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream
>>
>> being NULL, hence when trying to set rtd a few lines below we get an oops.
>> Fix by removing this line of code since CAPTURE substream will always be NULL.
> Why will the capture stream always be NULL?  There should be no
> intrinsic reason why we can't have hardware support for capturing
> compressed audio.

I think because we pass 0 as capture_count in snd_pcm_new_internal(). If 
I read the code correctly this will lead to _snd_pcm_new() to be called 
which in return will call snd_pcm_new_stream(pcm, 
SNDRV_PCM_STREAM_CAPTURE, capture_count) which will cause no substream 
to be allocated for the capture case, hence being NULL. I get an oops in 
my experimental driver when I set dynamic = 1 in FE dai link. If I did 
something wrong there that caused this, it's not obvious to me how.

Maybe a better fix would be to replace the 1 and 0 in 
snd_pcm_new_internal() call with rtd->dai_link->dpcm_playback and 
rtd->dai_link->dpcm_capture.
