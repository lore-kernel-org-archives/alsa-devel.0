From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to use implicit feedback with full duplex?
Date: Wed, 06 Feb 2013 21:13:29 +0100
Message-ID: <5112B969.50905@ladisch.de>
References: <51116F36.9040106@ladisch.de>
 <alpine.LNX.2.00.1302052326150.1207@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 07C2A260818
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 21:14:27 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1302052326150.1207@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Eldad Zack wrote:
> On Tue, 5 Feb 2013, Clemens Ladisch wrote:
>> I thought I'd try to use implicit feedback with my simple audio device:
>> [...]
>> This works fine when playing something:
> ...
>> But when I then try to record at the same time, the driver refuses to
>> configure the input endpoint (to the only format, which is already set):
>> And despite that "alreay in use" check, the input endpoint is affected
>> so much that playback breaks.
>>
>> Is full duplex supposed to work?  Does it work with other devices?
>
> This is probably a "yes, but" :)
> I use my device mostly full duplex, but with jack opening both
> playback and capture at the same time.
>
> I assume you are opening two different streams, one for playback and
> one for capture.

Jack *also* uses two different streams, but it opens them at the same
time.

> Can you try using jackd -d alsa -d hw:x with the device and see if that
> works for you?

That works.  This means that there is a race condition in the driver, or
that the different open/hw_params/prepare order trips it up.


Anyway, I feel safe now to enable implicit feedback for other devices.


Regards,
Clemens
