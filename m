From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Fwd: USB MIDI Specification Update Proposal
Date: Mon, 21 Jul 2014 10:21:01 +0200
Message-ID: <53CCCD6D.7030100@canonical.com>
References: <20140715234123.11232.qmail@vps-1011917-539.manage.myhosting.com>
 <53CC0FF2.8000702@canonical.com> <53CCCC9E.80402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2945826512F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 10:21:02 +0200 (CEST)
In-Reply-To: <53CCCC9E.80402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 2014-07-21 10:17, Clemens Ladisch wrote:
> David Henningsson wrote:
>> Forwarding this in case anyone is interested in influencing this
>> standard somehow
>
> MMA membership is available only for commercial entities, and begins
> at $500/year.

Yup. Not something for a private person, but maybe something for the 
Linux Foundation?

>> to make sure they don't do anything problematic for us...?
>
> As long as they call the new version "1.1", it should be compatible.
>
>>>    * Additional Device Attributes
>>>    * Bandwidth Descriptors
>>>    * Add Interrupt Mode
>>>    * Transfer Non-MIDI Data / Meta Event
>>>    * Product Identification (Logos)
>>
>> Are we interested?
>
> Not really.  As far as I can see, none of that it something that the
> driver would really care about (except for interrupt mode, which is
> a Roland extension already supported by Linux).

Okay, thanks. I guess at some point in the future it could make sense to 
expose "Product Identification" in sysfs or so.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
