From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: pcm: add 'applptr' event of
	tracepoint
Date: Mon, 12 Jun 2017 08:55:16 +0900
Message-ID: <95647bb3-4de1-96fa-0ea4-45d1d0a14516@sakamocchi.jp>
References: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
 <20170611064808.30572-3-o-takashi@sakamocchi.jp>
 <s5hpoea1n5c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5295B2664EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 01:55:23 +0200 (CEST)
In-Reply-To: <s5hpoea1n5c.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Jun 12 2017 01:53, Takashi Iwai wrote:
> On Sun, 11 Jun 2017 08:48:07 +0200,
> Takashi Sakamoto wrote:
>>
>> In design of ALSA PCM core, both of hardware-side and application-side
>> position on PCM buffer are maintained as a part of information for
>> runtime of PCM substream. In a view of ALSA PCM application, these two
>> positions can be updated by executing ioctl(2) with some commands.
>>
>> There's an event of tracepoint for hardware-side position; 'hwptr'.
>> On the other hand, no events for application-side position.
>>
>> This commit adds a new event for this purpose; 'applptr'. When
>> the application-side position is changed in kernel space, this event
>> is probed with useful information for developers.
>>
>> I note that the event is not probed for all of ALSA PCM applications,
>> because the application-side position is passively maintained in mmap
>> programming scenario. In this case, applications should be programmed
>> with ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR to commit the application-side
>> position to kernel land when it operates any PCM frames.
> 
> Here "should" is no correct choice of word.  As you already noted in
> the cover letter, the notification of appl_ptr in the mmap mode with
> the status/control mmap is voluntary.   So, it's not "should be
> programmed" but "may be programmed".

Indeed. It's better.


Regards

Takashi Sakamoto
