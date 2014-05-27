From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] AVB - network-based soundcards in ALSA
Date: Tue, 27 May 2014 11:55:26 -0500
Message-ID: <5384C37E.8060404@linux.intel.com>
References: <20140526130352.GA17414@austad.us> <s5ha9a3uw44.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 538F42608D3
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 18:59:17 +0200 (CEST)
In-Reply-To: <s5ha9a3uw44.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Henrik Austad <henrik@austad.us>
Cc: hansverk@cisco.com, alsa-devel@alsa-project.org, haustad@cisco.com
List-Id: alsa-devel@alsa-project.org


> This reminds me of the talk Pierre gave in LPC at San Diego a couple
> of years ago.  Although his topic was more about the audio time
> accounting, the framework mentioned at that time would fit with this
> scenario?

Yes it is related but the overall architecture on a first pass of 
reading seems different: the ideas we presented were more along the 
lines of letting every subsystem provide an accurate accounting of time 
and have some userspace parts see and compensate the difference between 
system, network, audio, video, clocks.
very interesting topic and RFC, thanks for posting this.
-Pierre
