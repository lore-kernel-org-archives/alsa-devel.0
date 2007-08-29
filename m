From: Romain Bossart <romain.bossart@free.fr>
Subject: Re: Audiophile Delta 24/96 Midi Out continuously sends
 zeroes (alsa 1.0.14)
Date: Thu, 30 Aug 2007 00:22:26 +0200
Message-ID: <fb4rj2$9ll$1@sea.gmane.org>
References: <46D4A1D6.7010604@free.fr>	<1188369280.902.1207813047@webmail.messagingengine.com>
	<1188378043.46d535bbab7f9@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C7CA10386D
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Aug 2007 00:22:44 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQVvn-0001Iz-GW
	for alsa-devel@alsa-project.org; Thu, 30 Aug 2007 00:22:35 +0200
Received: from vpn-samois.solopso.org ([62.147.132.141])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2007 00:22:35 +0200
Received: from romain.bossart by vpn-samois.solopso.org with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2007 00:22:35 +0200
In-Reply-To: <1188378043.46d535bbab7f9@imp.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Romain Bossart wrote:
> Selon Clemens Ladisch <cladisch@fastmail.net>:
> 
>> Romain Bossart wrote:
>>> My audiophile 24/96 Midi Out sends zeroes continuously,
>>> so I can't use any instrument. I checked that with amidi
>>> by looking at the stream output of a connected instrument
>>> (midi out -> instrument -> midi in -> amidi). Zeroes are
>>> sent whether or not I try to send (normal) midi messages.
>> Would it be possible to connect the midi out directly to the
>> midi in?
> 
> I also tried it, same results.
> 
>> Is the number of transmitted bytes in /proc/asound/cardX/midi0
>> about correct?

Yes, the number is correct. After a reboot, I prepared amidi
to output the incoming midi stream and switched on my instrument
for 2 seconds approx : around 10kB of zeroes were counted by
amidi and /proc/asound/card0/midi0.


> 
> Thank you !
> 
> Romain
> 
> 
>> Regards,
>> Clemens
>>
