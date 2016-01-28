From: Dan O'Donovan <dan@emutex.com>
Subject: Re: CherryTrail SST firmware limitations query
Date: Thu, 28 Jan 2016 21:20:57 +0000
Message-ID: <56AA8639.3030806@emutex.com>
References: <56A162A1.1070602@emutex.com> <56A1657A.5060600@emutex.com>
 <20160128162416.GR11130@localhost> <56AA4EA7.6060801@emutex.com>
 <56AA5872.3020809@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bert.emutex.com (bert.emutex.com [91.103.1.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 7404726596B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 22:21:01 +0100 (CET)
In-Reply-To: <56AA5872.3020809@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/28/2016 06:05 PM, Pierre-Louis Bossart wrote:
>
>>>> Are there any other limitations that I may need to be aware of in
>>>> the firmware (or in the SSP back-end driver) when attempting to
>>>> connect a new codec (TI PCM5122 initially) to SSP0.
>>> Bigger pole will be getting the firmware. Usually we support I2S and 
>>> TDM
>>> modes
>> Thanks very much for your reply, Vinod!  That probably explains why I'm
>> seeing clock signals from SSP0 but no audio data.
>> Can you tell me who I could contact to request SST firmware for CHT with
>> SSP0 support?
>
> This doesn't make sense to me. To the best of my knowledge the 
> firmware does support SSP0 but in a limited configuration compared to 
> SSP0. It should work for regular 48kHz audio in I2S mode but not in 
> TDM mode. If you see clock signals on SSP0 and no data then it's 
> probably because the DSP routing controls are incorrect.
> The best fix would be to use SSP2 really to get all the functionality.
>
Hi Pierre-Louis,

I've configured SSP0 for 48kHz audio in I2S mode, and I think the 
routing is correct (but would appreciate confirmation):

[Stream:'Headset Playback' -> 'media1_in'] -> ['media0_out mix 0' -> 
'media0_out' -> 'pcm0_in'] -> ['codec_out0 mix 0' -> 'codec_out0'] -> 
[Stream:'ssp0 Tx']

To see the clocks on SSP0, I found that I had to replace 'SSP_CODEC' (3) 
with 0 wherever it was used in sound/soc/intel/atom/sst-atom-controls.c

Unfortunately, our board is about to go into mass production so my 
chances of getting it changed to SSP2 are very slim.  Do you think it 
might be possible for us to get SSP0 working for I2S audio?
