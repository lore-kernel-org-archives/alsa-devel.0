From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Wed, 28 May 2014 10:14:55 -0500
Message-ID: <5385FD6F.3090100@linux.intel.com>
References: <20140526130352.GA17414@austad.us> <s5ha9a3uw44.wl%tiwai@suse.de>
 <5384C37E.8060404@linux.intel.com> <20140528094318.GC26498@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A97F26513D
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 17:15:35 +0200 (CEST)
Received: from ksouther-mobl1.amr.corp.intel.com (unknown [10.254.182.138])
 by linux.intel.com (Postfix) with ESMTP id D21026A4007
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 08:14:27 -0700 (PDT)
In-Reply-To: <20140528094318.GC26498@austad.us>
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

On 5/28/14, 4:43 AM, Henrik Austad wrote:
> On Tue, May 27, 2014 at 11:55:26AM -0500, Pierre-Louis Bossart wrote:
>>
>>> This reminds me of the talk Pierre gave in LPC at San Diego a couple
>>> of years ago.  Although his topic was more about the audio time
>>> accounting, the framework mentioned at that time would fit with this
>>> scenario?
>>
>> Yes it is related but the overall architecture on a first pass of
>> reading seems different: the ideas we presented were more along the
>> lines of letting every subsystem provide an accurate accounting of
>> time and have some userspace parts see and compensate the difference
>> between system, network, audio, video, clocks.
>
> Any documents/talks available for this? I found "Audio/system time
> alignment" from Plumbers 2012 (link at the bottom), is that the one?
>
> I see that this also covers AVB, but places everything AVB-related in
> userspace and then lets the application tie everything together. What
> was the design-rationale for this?
>
> To turn it around; our idea of placing this in the kernel was
> - easier to integrate with v4l
> - single interface (ALSA) for userspace to play audio
> - easy access to NIC internals to ship off frames and whatnot.
>
> what we found to be a pretty neat solution

There are cases where the clock estimation is done in userspace. I sort 
of recall that linuxptp does this for example. So if you want to any 
sort of alignment/correlation between network and local audio clock, it 
needs to be done where the information is available. And if you want to 
do any compensation on the audio data the processing also does below in 
userspace or DSP firmware, not in the kernel.

> Did we miss something crucial?
>
>> very interesting topic and RFC, thanks for posting this.
>
> Thanks for providing feedback! :)
>
> http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/11/2012-lpc-audio-time-alignment-bossart.pdf
>
