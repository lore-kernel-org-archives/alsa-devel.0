From: Romain Bossart <romain.bossart@free.fr>
Subject: Re: Audiophile Delta 24/96 Midi Out continuously sends
 zeroes (alsa 1.0.14)
Date: Mon, 03 Sep 2007 18:53:08 +0200
Message-ID: <46DC3BF4.9010204@free.fr>
References: <46D4A1D6.7010604@free.fr>
	<1188369280.902.1207813047@webmail.messagingengine.com>
	<1188378043.46d535bbab7f9@imp.free.fr>
	<fb4rj2$9ll$1@sea.gmane.org> <fbe8q7$hg3$1@sea.gmane.org>
	<1188802343.9390.1208579935@webmail.messagingengine.com>
	<1188826536.46dc0da8097bc@imp.free.fr>
	<1188833385.26232.1208641995@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.solopso.org (lns-bzn-47f-62-147-132-141.adsl.proxad.net
	[62.147.132.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 58B50103872
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 18:53:16 +0200 (CEST)
In-Reply-To: <1188833385.26232.1208641995@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote:
> Romain Bossart wrote:
>> Selon Clemens Ladisch <cladisch@fastmail.net>:
>>> That is, the zeroes are _not_ sent when you're not using jack?  When
>>> nothing is connected, or when you use aplaymidi or amidi to send
>>> something, everything is OK?
>> Here is a summary of the various tests I did. I have just one card: Audiophile
>> Delta 24/96. My kernel is now 2.6.22.1 RT patched & alsa 1.0.14,
>> Audio works perfectly. I don't think jack is the problem.
>>
>> Config #2 = Delta Midi Out -> (Midi In) Instrument (Midi Out/Thru) -> Delta Midi
>> In and 'amidi -p hw:0,0 -d'. Jack being started or not.
>>
>> Symptoms: tons of zeroes are shown by amidi as soon as I launch it. The stream
>> is so intense I can actually hear it in my speakers/monitors (need to switch to
>> better MIDI cables, I know!). amidi and /proc/asound/card0/midi0 give the same number
>> of transmitted bytes.
> 
> With "transmitted", you meant "received"?
> When Jack is not running, there is no software to send anything.  If the number
> of _transmitted_ bytes changes anyway, this would be a bug in ALSA.
Oops, 'reveived' is correct. Thank you.


>> Config #2b = Delta Midi Out -> Delta Midi In
>> and 'amidi -p hw:0,0 -d', Jack being started or not.
>>
>> Symptoms: identical to config#2. Moreover, if meanwhile I send some Midi commands
>> with amidi ('amidi -p hw:0,0 -S C01C'), I don't find this data in my dump.
> 
> Apparently, the output port is broken.  While it is theoretically
> possible that the driver doesn't initialize the card correctly, I cannot
> imagine a bug that would cause the port to presume that there is data to
> send.
You're right the output port seems to be broken.

> 
> Could you test if the port sends data even before the driver (or Linux)
> is loaded, or in Windows?
> 

I am not sure I can try this. I will change my card.

> 
> Regards,
> Clemens
> 
Thank you very much for your help.

Regards,
Romain
