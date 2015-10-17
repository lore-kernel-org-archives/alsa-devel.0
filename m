From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Splitting out controls
Date: Sat, 17 Oct 2015 10:54:09 -0500
Message-ID: <56226F21.3040902@linux.intel.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
 <s5h1tcug5w2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A5837260449
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 17:54:39 +0200 (CEST)
In-Reply-To: <s5h1tcug5w2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 10/16/15 11:00 AM, Takashi Iwai wrote:
> On Fri, 16 Oct 2015 17:35:30 +0200,
> Richard Fitzgerald wrote:
>>
>> On Tue, 2015-10-13 at 09:07 +0200, David Henningsson wrote:
>>>
>>> On 2015-10-12 22:59, James Cameron wrote:
>>>> On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
>>>>> I've written up the minutes here below
>>>>
>>>> Thanks!
>>>>
>>>>> Splitting out controls: Takashi
>>>>> ===============================
>>>>>
>>>>>    - Restricted access.  Consensus to restrict access to some controls due
>>>>> to possibility of breaking HW at kernel level. i.e. prevent feeding
>>>>> digital Mic into HP amp to prevent speaker over heating.
>>>>
>>>> I'd like that.  rt5631.  Avoiding at the moment by removing the controls.
>>>
>>> IIRC, the debate was over "do not expose dangerous controls to userspace
>>> at all" vs "expose dangerous controls controls only to root".
>>>
>>> I'm strongly voting for "do not expose to userspace at all".
>>>
>>> I personally believe that if the physical hardware can be set to state
>>> where it's bricked, the hardware itself is buggy.
>>>
>>> If the hardware is buggy, this should be worked around in BIOS or
>>> whatever firmware is present on the machine. Otherwise there is a bug in
>>> BIOS.
>>>
>>> If BIOS is buggy and cannot protect the machine from being physically
>>> damaged, then we need to work around that in the kernel. Otherwise there
>>> is a bug in the kernel.
>>>
>>> And if the kernel is buggy, we should fix the kernel. Period. :-)
>>>
>> I agree with you in principle that if it can break the hardware then
>> either it shouldn't be exposed to user-side at all, or it should be
>> checked by the kernel/driver to prevent bad settings.
>>
>> However, what about this sort of scenario: some codec has a speaker
>> volume range of 0..100, all of which are valid and safe. Manufacturer X
>> makes a device with an inadequate speaker that can be damaged with
>> volume settings above 80. How is that protected? There's nothing wrong
>> with the codec driver. There's no software at all for a speaker - it's
>> just a speaker. Where do we put a hard limit of 80 on a codec control
>> for one specific device? If it was my codec driver I don't want to have
>> to put a workaround for one specific device because manufacturer X chose
>> the wrong type of speaker. Or do we not care about the "stupid
>> manufacturer" cases and we're only interested in protecting the device
>> the control directly applies to - in this example it's a codec control
>> so it mustn't damage the codec but we don't care if poor hardware design
>> means it could damage other hardware connected to the codec.
>
> There is snd_soc_limit_volume() function to override the volume range
> from a machine driver for such a purpose.  This was what was suggested
> in the meeting.

To say that a configuration is 'safe' requires a breadth of information 
from thermal, acoustic and mechanical design that is just not available 
to kernel contributors who work in parallel on different building blocks 
and different configurations. Adding a safeguard in the machine driver 
is not practical: it's not uncommon for manufacturers to swap out 
speakers to save a couple of cents on a specific production batch and a 
value set in stone in a driver would not work for all those different 
batches.
So yes everyone should try and make sure that there are no 'dangerous' 
controls at their individual level but there is no way to protect 
hardware integrity in all cases if users punch-in values in alsamixer.
