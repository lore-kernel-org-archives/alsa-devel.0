From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Fri, 08 Mar 2013 15:22:09 +0100
Message-ID: <5139F411.10407@topic.nl>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <513721E0.8000605@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D44D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob14.myregisteredsite.com
 (atl4mhob14.myregisteredsite.com [209.17.115.52])
 by alsa0.perex.cz (Postfix) with ESMTP id ACC4726170B
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 15:22:12 +0100 (CET)
Received: from mailpod.hostingplatform.com (mail.networksolutionsemail.com
 [205.178.146.50])
 by atl4mhob14.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r28EMARt026564
 for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2013 09:22:11 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3D44D@DBDE01.ent.ti.com>
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

On 03/06/2013 12:19 PM, Bedia, Vaibhav wrote:
> On Wed, Mar 06, 2013 at 16:30:48, Daniel Mack wrote:
>> On 06.03.2013 11:54, Bedia, Vaibhav wrote:
>>> Hi Daniel,
>>>
>>> On Tue, Mar 05, 2013 at 21:31:59, Daniel Mack wrote:
>>> [...]
>>>>
>>>> As Michal described, we used a board with a multichannel Codec on it,
>>>> which connects 3 of its I2S inputs to the AM33xx's AXR data lines.
>>>>
>>>> Software wise, we tested with 'aplay -cX', and that seems to work just fine.
>>>>
>>>
>>> Since you are using a multichannel codec things are a lot simplified for you :)
>>> Someone might want to hook up multiple codecs to get multi-channel behavior.
>>> There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
>>> sync. I haven't really followed the recent ASoC changes so I don't know whether
>>> something like this can be handled right now.
>>
>> I would rather instanciate multiple McASP cores for such setups, so you
>> can (in theory) also make them operate on different bit depths and clock
>> dividers. You think that's possible as well?
>
> Yeah. Using multiple McASPs would be much simpler to handle both in s/w and h/w.

Would it?

The McASP has multiple serializers, but they all share the same clocks 
and format settings. The data will come in as "L1 L2 L3 .. R1 R2 R3 .." 
so the code would have keep track of which channels have to go where, 
and rearrange it to the clients. And it must be able to dynamically 
add/remove channels without disturbing the other streams.

So unless you want to physically add more McASP hardware to the system, 
I don't see how this would be "simpler" to handle than other options.

A way to "group" the codecs together is much simpler to implement (which 
is simply proven by the simple fact that I implemented it on my system) 
and it makes it very easy to control on the user side too - the 
selection of codecs is just a mixer control.

Mike.
