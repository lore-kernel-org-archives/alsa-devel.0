From: Uli Franke <uli.franke@weiss.ch>
Subject: Re: Dummy module and sample rates
Date: Thu, 24 Sep 2015 12:49:22 +0200
Message-ID: <5603D532.9080201@weiss.ch>
References: <56029069.60700@weiss.ch> <56039FF3.3030203@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server11.hostfactory.ch (server11.hostfactory.ch
 [62.146.13.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C86C260526
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 12:49:23 +0200 (CEST)
Received: from [192.168.1.112] (165.90.0.85.dynamic.wline.res.cust.swisscom.ch
 [85.0.90.165])
 by server11.hostfactory.ch (Postfix) with ESMTPA id DAC8F60438339
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 12:49:22 +0200 (CEST)
In-Reply-To: <56039FF3.3030203@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> I fiddled around with the Dummy module and it seems to be the thing
>> we're looking for. I observed a rather strange behavior though:
>>
>> I set the hw params sample rate to 44k1 without error, but a subsequent
>> call of snd_pcm_start returns EPIPE. When setting hw params sample rate
>> to 4k this does not happen.
> 
> In theory, this error code is returned if you didn't write any samples
> into the buffer before starting.
> 
> An underrun is possible too, but should be reported later AFAIK.
> Could you check if a larger buffer size helps?

I checked if this is actually an XRun, as this is the official error
code. But even recover didn't have any effect.

When I write samples before starting the stream, snd_pcm_start returns

   File descriptor in bad state (-77)

which is obvious as the state of the stream changes from PREPARED to
RUNNING.

I tried to increase the buffer but with no effect.

No error occurs when I just write samples and omit the snd_pcm_start. I
just read some examples and got the impression that this seems to be
common practice anyhow. But up to now all my ALSA interfacing programs
actively started the stream and I never had any similar effect.

You can find a small test program here:

http://460c9235de50fe3b.paste.se/

Regards,
Uli
