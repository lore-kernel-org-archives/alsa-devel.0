From: =?UTF-8?B?UHJ6ZW15c8WCYXcgUnVkeQ==?= <prudy1@o2.pl>
Subject: Re: [PATCH - microII 1/1] conf/cards: add Audio
 Advantage Micro II
Date: Fri, 28 Jun 2013 13:13:38 +0200
Message-ID: <51CD6FE2.5080200@o2.pl>
References: <1372369954-32403-1-git-send-email-prudy1@o2.pl>
 <1372369954-32403-2-git-send-email-prudy1@o2.pl>
 <s5hvc4ymtoi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moh2-ve3.go2.pl (moh2-ve3.go2.pl [193.17.41.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BBC1261670
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 13:13:42 +0200 (CEST)
Received: from moh2-ve3.go2.pl (unknown [10.0.0.208])
 by moh2-ve3.go2.pl (Postfix) with ESMTP id B8867370A23
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 13:13:41 +0200 (CEST)
Received: from unknown (unknown [10.0.0.142])
 by moh2-ve3.go2.pl (Postfix) with SMTP
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 13:13:41 +0200 (CEST)
In-Reply-To: <s5hvc4ymtoi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please find the following description:

------------------
This patch is adding extensive support (beside standard usb audio class)
for Audio Advantage Micro II usb sound card. This patch depends on
related kernel patch.
Features included:
- Add AES bits controls (so they can be accessible via device suffix
AESn= as well as via tools like iecset).
- SPDIF switch control added to turn on/off the optical transmitter
(accessible e.g. via alsamixer tool)
------------------

Best,
Przemek

On 2013-06-28 12:11, Takashi Iwai wrote:
> At Thu, 27 Jun 2013 23:52:34 +0200,
> Przemek Rudy wrote:
>>
>> Signed-off-by: Przemek Rudy <prudy1@o2.pl>
> 
> Ditto like the kernel patch.  The patch description is one of the most
> important things.  Please give it more.
> 
> 
> thanks,
> 
> Takashi
> 
>>
>> diff --git a/src/conf/cards/USB-Audio.conf b/src/conf/cards/USB-Audio.conf
>> index 0d93175..8a6d9ca 100644
>> --- a/src/conf/cards/USB-Audio.conf
>> +++ b/src/conf/cards/USB-Audio.conf
>> @@ -101,6 +101,41 @@ USB-Audio."Audiophile USB (tm)".pcm.iec958 {
>>  	}
>>  }
>>  
>> +# For this card we can (and must to get IEC61937) set AES bits
>> +USB-Audio."MicroII".pcm.iec958 "cards.USB-Audio.Audio Advantage MicroII.pcm.iec958"
>> +USB-Audio."Audio Advantage MicroII".pcm.iec958 {
>> +	@args [ CARD AES0 AES1 AES2 AES3 ]
>> +	@args.CARD { type string }
>> +	@args.AES0 { type integer }
>> +	@args.AES1 { type integer }
>> +	@args.AES2 { type integer }
>> +	@args.AES3 { type integer }
>> +
>> +    type hooks
>> +    slave.pcm {
>> +		type hw
>> +		card $CARD
>> +    }
>> +
>> +    hooks.0 {
>> +		type ctl_elems
>> +		hook_args [
>> +			{
>> +				interface PCM
>> +				name "IEC958 Playback Default"
>> +				preserve true
>> +				optional true
>> +				value [ $AES0 $AES1 $AES2 $AES3 ]
>> +			}
>> +			{
>> +				name "IEC958 Playback Switch"
>> +				lock true
>> +				preserve true
>> +				value 1
>> +			}
>> +		]
>> +	}
>> +}
>>  
>>  ################################################################################
>>  
>> -- 
>> 1.8.1.4
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
