From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 5/5] ASoC: Intel: add BYTCR machine
 driver with RT5640
Date: Wed, 05 Nov 2014 09:54:59 +0200
Message-ID: <5459D7D3.3090501@linux.intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <1415079068-4979-6-git-send-email-vinod.koul@intel.com>
 <54589A0E.5040301@linux.intel.com> <20141104093244.GE1870@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CB212261A66
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 08:55:04 +0100 (CET)
In-Reply-To: <20141104093244.GE1870@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/04/2014 11:32 AM, Vinod Koul wrote:
> On Tue, Nov 04, 2014 at 11:19:10AM +0200, Jarkko Nikula wrote:
>>
>> I think it's worth to have same kcontrol and card names than
>> byt-rt5640 in case this is going to replace byt-rt5640.c since then
>> users can continue to use the same asound.state file. E.g. speakers
>> won't mute because of "Speaker" changes to "Ext Spk".
> It would have helped if the DSP controls were not there. The DSP controls
> need to be routed too, so existing conf files would need to be updated.
>
> So, do you still recommend changing :)
>
Do new controls affect PCM pass through? I was thinking if they affect 
only compressed streams then it'd be useful if existing state files 
continue working for PCM pass through. It's always painful if kcontol 
name changes render audio muted and user have to go through gazillions 
of kcontrols :-(

-- 
Jarkko
