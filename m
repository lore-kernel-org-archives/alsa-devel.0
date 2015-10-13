From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Splitting out controls
Date: Tue, 13 Oct 2015 09:55:57 -0500
Message-ID: <561D1B7D.9080307@linux.intel.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F0EE264EF3
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:56:00 +0200 (CEST)
In-Reply-To: <561CADA8.3040903@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, James Cameron <quozl@laptop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/13/15 2:07 AM, David Henningsson wrote:
>
>
> On 2015-10-12 22:59, James Cameron wrote:
>> On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
>>> I've written up the minutes here below
>>
>> Thanks!
>>
>>> Splitting out controls: Takashi
>>> ===============================
>>>
>>>   - Restricted access.  Consensus to restrict access to some controls
>>> due
>>> to possibility of breaking HW at kernel level. i.e. prevent feeding
>>> digital Mic into HP amp to prevent speaker over heating.
>>
>> I'd like that.  rt5631.  Avoiding at the moment by removing the controls.
>
> IIRC, the debate was over "do not expose dangerous controls to userspace
> at all" vs "expose dangerous controls controls only to root".
>
> I'm strongly voting for "do not expose to userspace at all".
>
> I personally believe that if the physical hardware can be set to state
> where it's bricked, the hardware itself is buggy.
>
> If the hardware is buggy, this should be worked around in BIOS or
> whatever firmware is present on the machine. Otherwise there is a bug in
> BIOS.
>
> If BIOS is buggy and cannot protect the machine from being physically
> damaged, then we need to work around that in the kernel. Otherwise there
> is a bug in the kernel.
>
> And if the kernel is buggy, we should fix the kernel. Period. :-)

There are just too many variables linked to acoustic, mechanical and 
thermal design that just can't be handled with a simple rule at the 
kernel level or even BIOS/firmware. There were quite a few people in the 
room who voiced their opinion that handling 'dangerous' controls was an 
exercise for the integrator, not something that can be handled with a 
one-size-fits-all fix. 'userspace' is also a vague definition, most 
audio servers will use profiles that will avoid using bad 
configurations. It's not clear to me that we have to protect against a 
user setting random values with alsamixer.
