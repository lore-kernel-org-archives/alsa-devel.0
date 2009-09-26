From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH 1/4] snd-usb-caiaq: Do not disable local
	interrupts
Date: Sat, 26 Sep 2009 17:06:23 +0100 (BST)
Message-ID: <alpine.BSO.2.01.0909261630400.8841@zrgural.vwaro.pbz>
References: <alpine.BSO.2.01.0909220805420.25926@zrgural.vwaro.pbz>
	<1253892138-10827-1-git-send-email-mark@pogo.org.uk>
	<20090925160024.GT21654@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metheny.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id A1E571037FF
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Sep 2009 18:06:25 +0200 (CEST)
In-Reply-To: <20090925160024.GT21654@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Sep 2009, Daniel Mack wrote:

> On Fri, Sep 25, 2009 at 04:22:15PM +0100, Mark Hills wrote:
>> The driver documentation states that local interrupts are already
>> disabled when trigger() is called, so only a spinlock is required.
>
> Hmm. I assume you tested them well. But I remember to have had quite 
> some trouble at this point on SMP machines and ended up with that 
> irqsave code. However, if you're sure that fixes a bug or is not 
> necessary, let's take the patches and I'll test them once I'm back home 
> around mid Oct.

I did check both non and SMP machines, and it corresponds to the docs. I 
also removed the patches to verify I could reproduce the original 
problems.

As I missed off the the Signed-off-by, I'll not rush to resubmit them; 
let's wait until you have also tested them.

> Btw - your Signed-off-by: is missing on all of them :)
>
> Thanks,
> Daniel
>
>
>> ---
>>  sound/usb/caiaq/audio.c |    5 ++---
>>  1 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
>> index 121af06..ce193a5 100644
>> --- a/sound/usb/caiaq/audio.c
>> +++ b/sound/usb/caiaq/audio.c
>> @@ -72,15 +72,14 @@ static void
>>  deactivate_substream(struct snd_usb_caiaqdev *dev,
>>  		     struct snd_pcm_substream *sub)
>>  {
>> -	unsigned long flags;
>> -	spin_lock_irqsave(&dev->spinlock, flags);
>> +	spin_lock(&dev->spinlock);
>>
>>  	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>  		dev->sub_playback[sub->number] = NULL;
>>  	else
>>  		dev->sub_capture[sub->number] = NULL;
>>
>> -	spin_unlock_irqrestore(&dev->spinlock, flags);
>> +	spin_unlock(&dev->spinlock);
>>  }
>>
>>  static int
>> --
>> 1.6.4.4
>>
>

-- 
Mark
