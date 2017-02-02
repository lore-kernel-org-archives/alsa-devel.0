From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 17/53] ALSA: x86: Drop unused hw_silence
 field
Date: Thu, 2 Feb 2017 14:26:30 -0600
Message-ID: <1cc13469-6060-71bd-c10b-2e60ed4d4b0f@linux.intel.com>
References: <20170202170307.24484-1-tiwai@suse.de>
 <20170202170307.24484-19-tiwai@suse.de>
 <110ce179-24f5-9898-3d26-44e4c559e55a@linux.intel.com>
 <s5hmve4ickb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 77AE12668AD
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 21:26:33 +0100 (CET)
In-Reply-To: <s5hmve4ickb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org



On 02/02/2017 02:04 PM, Takashi Iwai wrote:
> On Thu, 02 Feb 2017 20:11:10 +0100,
> Pierre-Louis Bossart wrote:
>> On 2/2/17 11:02 AM, Takashi Iwai wrote:
>>> It's nowhere used.  Let's drop it.
>> That's one of the things I wanted to add. When you start playback
>> there is a 1-2s period where the receiver is still looking at the data
>> to figure out if it's PCM or compressed, and you lose those 1-2s of
>> audio. The hw silence mode is a way to keep the link active.
> I see.  Yes, the feature would be useful.
>
>> But I guess we can remove first and re-add later so no objections.
> Agreed.
>
> How would it be actually implemented?  Just avoid to turn off the
> audio config bits at trigger callback, etc?
>
> Since the runtime PM will be in the same game, we'll have to cope with
> it, too.
I must admit I don't remember the details, just that's it's the same 
behavior as the HDAudio KAE (Keep Alive Enable) functionality.

>
>
> thanks,
>
> Takashi
