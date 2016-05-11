From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: firewire-lib: drop skip argument
 from helper functions to queue a packet
Date: Thu, 12 May 2016 01:14:53 +0900
Message-ID: <57335A7D.4020207@sakamocchi.jp>
References: <1462919709-8692-1-git-send-email-o-takashi@sakamocchi.jp>
 <5732E3C7.2030604@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 490B52667C3
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 18:14:58 +0200 (CEST)
In-Reply-To: <5732E3C7.2030604@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On May 11 2016 16:48, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On most of audio and music units on IEEE 1394 bus which ALSA firewire stack
>> supports (or plans to support), CIP with two quadlets header is used.
>> Thus, there's no cases to queue packets with blank payload. If such packets
>> are going to be queued, it means that they're for skips of the cycle.
>>
>> This commit simplifies helper functions to queue a packet.
> 
>> @@ -383,8 +382,10 @@ static int queue_packet(struct amdtp_stream *s,
>>  	p.tag = TAG_CIP;
>>  	p.header_length = header_length;
>> -	p.payload_length = (!skip) ? payload_length : 0;
>> -	p.skip = skip;
>> +	if (payload_length > 0)
>> +		p.payload_length = payload_length;
>> +	else
>> +		p.skip = true;
> 
> This can be simplified to:
> 	p.payload_length = payload_length;
> 	p.skip = payload_length == 0;

Yep, but I prefer to split assignment from evaluation in different
lines, just from my taste.

> Acked-by: Clemens Ladisch <clemens@ladisch.de>


Thanks

Takashi Sakamoto
