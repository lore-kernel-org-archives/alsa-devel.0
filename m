From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH]: x86_64, audio: Fix system panic when DMA > 40 bits
Date: Thu, 02 May 2013 12:20:24 -0600
Message-ID: <5182AE68.9010905@wwwdotorg.org>
References: <1367435048-66137-1-git-send-email-travis@sgi.com> <518205A9.1050409@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <518205A9.1050409@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Mike Travis <travis@sgi.com>, Stephen Warren <swarren@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Russ Anderson <rja@sgi.com>
List-Id: alsa-devel@alsa-project.org

On 05/02/2013 12:20 AM, David Henningsson wrote:
> On 05/01/2013 09:04 PM, Mike Travis wrote:
>> The audio driver mistakenly allows 64 bit addresses to be created for
>> the audio driver on Nvidia GPUs.  Unfortunately, the hardware normally
>> only supports up to 40 bits of DMA.  This can cause system panics as
>> well as misdirected data when the address is > 40 bits as the upper
>> part the address is truncated.
> 
> Thanks for this patch. Stephen Warren, is this something you can
> confirm/deny, and do you know what range of hardware this actually
> applies to?

It's certainly plausible that the GPU's internal physical addresses are
less than a full 64-bits, and this probably affects PCI accesses too.
