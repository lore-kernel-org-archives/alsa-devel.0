From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Splitting out controls
Date: Tue, 13 Oct 2015 09:07:20 +0200
Message-ID: <561CADA8.3040903@canonical.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 645242606FB
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 09:07:21 +0200 (CEST)
In-Reply-To: <20151012205908.GA25971@us.netrek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Cameron <quozl@laptop.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-10-12 22:59, James Cameron wrote:
> On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
>> I've written up the minutes here below
>
> Thanks!
>
>> Splitting out controls: Takashi
>> ===============================
>>
>>   - Restricted access.  Consensus to restrict access to some controls due
>> to possibility of breaking HW at kernel level. i.e. prevent feeding
>> digital Mic into HP amp to prevent speaker over heating.
>
> I'd like that.  rt5631.  Avoiding at the moment by removing the controls.

IIRC, the debate was over "do not expose dangerous controls to userspace 
at all" vs "expose dangerous controls controls only to root".

I'm strongly voting for "do not expose to userspace at all".

I personally believe that if the physical hardware can be set to state 
where it's bricked, the hardware itself is buggy.

If the hardware is buggy, this should be worked around in BIOS or 
whatever firmware is present on the machine. Otherwise there is a bug in 
BIOS.

If BIOS is buggy and cannot protect the machine from being physically 
damaged, then we need to work around that in the kernel. Otherwise there 
is a bug in the kernel.

And if the kernel is buggy, we should fix the kernel. Period. :-)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
