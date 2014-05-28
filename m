From: Henrik Austad <henrik@austad.us>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Wed, 28 May 2014 11:43:18 +0200
Message-ID: <20140528094318.GC26498@austad.us>
References: <20140526130352.GA17414@austad.us> <s5ha9a3uw44.wl%tiwai@suse.de>
 <5384C37E.8060404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E6672654DF
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 11:47:46 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id p9so5535341lbv.25
 for <alsa-devel@alsa-project.org>; Wed, 28 May 2014 02:47:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5384C37E.8060404@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, hansverk@cisco.com, alsa-devel@alsa-project.org, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2014 at 11:55:26AM -0500, Pierre-Louis Bossart wrote:
> 
> >This reminds me of the talk Pierre gave in LPC at San Diego a couple
> >of years ago.  Although his topic was more about the audio time
> >accounting, the framework mentioned at that time would fit with this
> >scenario?
> 
> Yes it is related but the overall architecture on a first pass of
> reading seems different: the ideas we presented were more along the
> lines of letting every subsystem provide an accurate accounting of
> time and have some userspace parts see and compensate the difference
> between system, network, audio, video, clocks.

Any documents/talks available for this? I found "Audio/system time
alignment" from Plumbers 2012 (link at the bottom), is that the one?

I see that this also covers AVB, but places everything AVB-related in
userspace and then lets the application tie everything together. What
was the design-rationale for this?

To turn it around; our idea of placing this in the kernel was
- easier to integrate with v4l
- single interface (ALSA) for userspace to play audio
- easy access to NIC internals to ship off frames and whatnot.

what we found to be a pretty neat solution

Did we miss something crucial?

> very interesting topic and RFC, thanks for posting this.

Thanks for providing feedback! :)

http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/11/2012-lpc-audio-time-alignment-bossart.pdf

-- 
Henrik Austad
