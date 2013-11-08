From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Fri, 08 Nov 2013 12:27:11 +0200
Message-ID: <527CBC7F.4000805@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>	
 <5269665E.9050102@iki.fi> <1383887323.6455.37.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 065BD265656
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 11:27:17 +0100 (CET)
In-Reply-To: <1383887323.6455.37.camel@Wailaba2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Langlois <olivier@trillion01.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

08.11.2013 07:08, Olivier Langlois kirjoitti:
> On Thu, 2013-10-24 at 21:26 +0300, Anssi Hannula wrote:
>> 24.10.2013 21:10, Anssi Hannula kirjoitti:
>>> Hi all!
>>>
>>> Here's another revision of the ATI/AMD multichannel+HBR patchset.
>>>
>>> Changes:
>>> - added customizable callbacks instead of polluting generic code
>>> - fixed wrong codec id in rev3+ check (as previously noted)
>>> - cosmetics
>>>
>>> I've only tested this on NVIDIA/Intel, but I'd guess at least Peter
>>> should be able to test this on AMD in a few days or so. The earlier
>>> revisions were tested to fully work.
>>>
>>> Combined patch can be found at: http://onse.fi/files/atihdmi5.patch
>>> However, this patchset is on top recent sound-next commits so it does not
>>> directly apply on older kernels.
>>
>> Aand that would be http://onse.fi/files/atihdmi6.patch not 5.
>>
>>> Olivier, I hope you will be able to test this at some point as well
>>> (same things as last time), even though it will be a bit more work :)
>>
> Anssi,
> 
> I have tried to patch 3.11.7 and the code in patch_hdmi.c looks too
> different to be able to able to manually merge the rejected hunks.
> 
> What is sound-next? A git branch? Where can I get it?

The sound tree is at:
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/

You can use the master branch now, it has been merged there.

> How independant is the sound subsystem from the rest of the kernel? My
> guess is that it is not that tightly coupled with the rest and dropping
> sound-next version of patch_hdmi.c into my 3.11.7 source tree could work
> or require minimal work. Will upgrade to 3.12 in a couple of day....

Often you can just copy the sound/pci/hda directory from a newer kernel
and then build the modules for the current kernel
("make -C/lib/modules/$(uname -r)/build M=$PWD") with only minimal
changes and possibly disabling unused modules in Makefile.

-- 
Anssi Hannula
