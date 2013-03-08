From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Fri, 08 Mar 2013 08:29:49 +0100
Message-ID: <5139936D.9080001@topic.nl>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <20130306105713.GF4896@opensource.wolfsonmicro.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob09.myregisteredsite.com
 (atl4mhob09.myregisteredsite.com [209.17.115.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 588192616F1
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 08:29:52 +0100 (CET)
Received: from mailpod.hostingplatform.com (mail.networksolutionsemail.com
 [205.178.146.50])
 by atl4mhob09.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r287ToUF018444
 for <alsa-devel@alsa-project.org>; Fri, 8 Mar 2013 02:29:50 -0500
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
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
> On Wed, Mar 06, 2013 at 16:27:15, Mark Brown wrote:
>> On Wed, Mar 06, 2013 at 10:54:52AM +0000, Bedia, Vaibhav wrote:
>>
>>> Since you are using a multichannel codec things are a lot simplified for you :)
>>> Someone might want to hook up multiple codecs to get multi-channel behavior.
>>> There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
>>> sync. I haven't really followed the recent ASoC changes so I don't know whether
>>> something like this can be handled right now.
>>
>>> Mark, Liam,
>>
>>> Any suggestions?
>>
>> Nobody with any interest in such systems has stepped up to work on the
>> framework, and of course relatively little CPU hardware supports
>> multiple streams on a single DAI.
>>
>
> Ok. Thinking more on this I guess the situation I described above will indeed be a rare
> case. There would be additional complexity in ensuring that the codecs are always operating
> in sync. It would perhaps be simpler to cascade the codecs (if supported) and use only one
> interface to transfer the data. Or just use multichannel codec like Michal and Daniel
> are doing.

I have 9 codecs connected, and the main problem to solve was to get the 
system to start ALL of them instead of just one.

I solved that by creating a "multiplex" codec, which in itself doesn't 
do anything. It exports a mixer where you can switch on/off the codecs 
you want to use, and it forwards all commands (_ops) to the codecs that 
are enabled. The serializer settings are sent to the asp driver as if 
they are TDM masks (using the bits to enable serializers instead).

In userland you see 10 codecs, you can use each separately, or use the 
10th codec (the multiplexer) to use any combination of other codecs.

-- 
Mike Looijmans - Topic Automation
