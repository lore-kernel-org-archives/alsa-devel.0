From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Wed, 04 Dec 2013 20:11:51 -0800
Message-ID: <529FFD07.5040408@gmail.com>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box> <529CA3FC.1040301@gmail.com>
 <529CAE8D.6020003@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3782654DE
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 05:11:55 +0100 (CET)
Received: by mail-pd0-f177.google.com with SMTP id q10so23460279pdj.8
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 20:11:54 -0800 (PST)
In-Reply-To: <529CAE8D.6020003@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 08:00 AM, Daniel Mack wrote:
>>> Technically yes, but changing that would mean breakage for all other
>>> users, and making it configurable would result in yet another moving
>>> part which makes things even more complex.
>>
>> How would this cause breakage?  Users that use 2 stereo substreams could
>> still work normally.
>
> Yes, unless you opened the first subdevice with more than 2 channels.
> Then an existing user for the second stream breaks. IOW: the possible
> configuration and usage for subdevice 1 changes depending on that of
> subdevice 0.

Suppose a 2nd PCM device is added that would allow 1-4 channel 
playback/capture (call it "Multichannel Audio" or something).  This pcm1 
would be mutually exclusive with pcm0 (I.e. while one is open you can't 
use the other).

Existing applications using hw:n,0,0 and hw:n,0,1 see the exact same 
interface/behavior.  The only failure mode is if the multichannel PCM is 
in use.

Applications using multichannel work-flows would use hw:n,1.

While it's not a "just works" solution -- directing users to hw:n,1 is a 
whole lot better than teaching them how to set up a multi plugin.

-gabe
