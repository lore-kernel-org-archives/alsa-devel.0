From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 08/19] firewire-motu: add MOTU specific
	protocol layer
Date: Mon, 30 Jan 2017 15:11:10 +0900
Message-ID: <40d5c576-da27-6c5f-6a49-b16a23a35fb2@sakamocchi.jp>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
 <20170129035417.2095-9-o-takashi@sakamocchi.jp>
 <20170129131604.GA15067@marvin.atrad.com.au>
 <91783045-ce45-cd2b-8f78-cfc24e21ba1d@sakamocchi.jp>
 <20170130050455.GO8159@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 23BDA2669B5
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 07:11:13 +0100 (CET)
In-Reply-To: <20170130050455.GO8159@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jan 30 2016 14:04, Jonathan Woithe wrote:
>> If you have different stories, please show reasoning from enough facts, at
>> first. Not from your opinion or memories.
>
> Sending timestamps derived from a fixed interval did not provide reliable
> audio output from these devices in general. This was observed with real
> hardware and tangentially, the hardware did not send SPH timestamps with a
> fixed interval either.  At 48 kHz for example, deviations from a difference
> of 512 were routinely observed in both directions even with official drivers
> on vendor-supported OSes.

This statement includes mixture of facts, your opinions and the lack of 
information:
  - facts:
   - When reading packet dumps, the sequence of SPH in tx/rx packets
     includes time stamps which are not even lapses.
  - opinions:
   - The sequence of SPH with even lapses doesn't bring reliable audio
     output.
  - the others without enough information:
   - As long as _you_ experienced, putting time stamps with even lapses
     to SPH in rx packets causes non-reliable audio output. (But which
     models? the way to generate the time stamp? and so on?)

As long as I investigated, packets from 
828/828mk2/828mk3(FireWire/Hybrid) at 48.0kHz of sampling transmission 
frequency(stf) the sequence of SPH in each data block includes differed 
lapses. In theory, in this stf, the gap between two successive time 
stamp should be 512 ticks at time representation on IEEE 1394 bus, 
however it's sometimes 511 or 513 in fact. This is also the same packets 
from driver for Windows operating system.The algorithm to generate 
exactly the same sequence of SPH is not clear yet.

However, we program IEC 61883-1/6 engine of ALSA firewire stack with an 
assumption that time stamps include even lapses:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/amdtp-stream.c#n301

As long as handling packets with this engine, the sequence of time stamp 
should includes even lapses for correct calculation. In this reason, I 
use the pre-computed table.


Well, when using a kind of words such as 'in general', 'all', 
'absolutely', 'resolutely', it's a signs of over-generalization and you 
should pay enough attention to what you're going to describe. And when 
describing the facts, subject of contexts is important. You still have a 
tendency of these wrong directions, in my opinion.


Regards

Takashi Sakamoto
