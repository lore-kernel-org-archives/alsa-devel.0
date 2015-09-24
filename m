From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Dummy module and sample rates
Date: Thu, 24 Sep 2015 20:40:00 +0200
Message-ID: <56044380.4030109@ladisch.de>
References: <56029069.60700@weiss.ch> <56039FF3.3030203@ladisch.de>
 <5603D532.9080201@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 986D126058F
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 20:40:29 +0200 (CEST)
In-Reply-To: <5603D532.9080201@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uli Franke <uli.franke@weiss.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Uli Franke wrote:
>>> I set the hw params sample rate to 44k1 without error, but a subsequent
>>> call of snd_pcm_start returns EPIPE.
>>
>> In theory, this error code is returned if you didn't write any samples
>> into the buffer before starting.

> T(snd_pcm_start(pcm));
>
> n = snd_pcm_writei(pcm,
> 	             buffer,
> 	             ARRAY_SIZE(buffer) / channels);

And indeed this code tries to start the device without any samples in
the buffer.

>>> When setting hw params sample rate to 4k this does not happen.

This appears to be an artifact of the resampler.

> When I write samples before starting the stream, snd_pcm_start returns
>
>    File descriptor in bad state (-77)
>
> which is obvious as the state of the stream changes from PREPARED to
> RUNNING.

To prevent the device from starting automatically, change the
start_threshold.


Regards,
Clemens
