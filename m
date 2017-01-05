From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: firewire-lib: change structure
 member with proper type
Date: Thu, 5 Jan 2017 09:10:50 +0900
Message-ID: <6c05523c-3187-033c-9660-d1df49929ebf@sakamocchi.jp>
References: <20170103025834.17159-1-o-takashi@sakamocchi.jp>
 <20170103025834.17159-4-o-takashi@sakamocchi.jp>
 <ce9f7680-6b12-ec1f-7d0d-1ef931b73d0a@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5BD362675E7
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 01:10:56 +0100 (CET)
In-Reply-To: <ce9f7680-6b12-ec1f-7d0d-1ef931b73d0a@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Jan 4 2017 20:13, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> The 'amdtp_stream' structure is initialized by a call of
>> 'amdtp_stream_init()'. Although a parameter of this function is for bit
>> flags of packet attributes, its type is enumerator.
>
> This is the correct type to use for an enumeration consisting of bit
> flags.  What problem do you see with this?

We have cases that an actual value to the parameter is not one of 
enumeration-constants. I had this concern and posted the patch.

But this is permitted, as you said. C language specification has loose 
constrains to the actual value of the type, just within a range of 
enumeration-constants. I understand that a list of enumeration-constants 
is just used to decide the actual integer type of the type.

I'll post revert patch. Thanks for your indication!

>>  int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
>> -		      enum amdtp_stream_direction dir, enum cip_flags flags,
>> +		      enum amdtp_stream_direction dir, int flags,
>>  		      unsigned int fmt,


Regards

Takashi Sakamoto
