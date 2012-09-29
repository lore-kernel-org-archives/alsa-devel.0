From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Sat, 29 Sep 2012 15:12:29 -0500
Message-ID: <5067562D.50704@linux.intel.com>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1348820142-15822-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <50656F02.5030005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 026B4261628
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 22:12:53 +0200 (CEST)
In-Reply-To: <50656F02.5030005@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/28/2012 04:33 AM, Clemens Ladisch wrote:
> Pierre-Louis Bossart wrote:
>> @@ -1712,6 +1777,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
>>   				 /* SNDRV_PCM_INFO_RESUME |*/
>>   				 SNDRV_PCM_INFO_PAUSE |
>>   				 SNDRV_PCM_INFO_SYNC_START |
>> +				 SNDRV_PCM_INFO_HAS_WALL_CLOCK |
>
> ... but not if this device is connected to an S/PDIF input.

Yeah, but I can't figure out what happens here. HDAudio is the clock 
master in all cases, unless the audio codec does an ASRC I don't think 
this works. I've looked at the spec several times, asked around, this 
case looks wild.
