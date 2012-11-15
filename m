From: Colin Fletcher <colin.m.fletcher@googlemail.com>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Thu, 15 Nov 2012 13:15:50 +0000
Message-ID: <50A4EB06.1030404@googlemail.com>
References: <50587F96.8080005@googlemail.com> <505883EA.6070808@ladisch.de>
 <5058898C.6020608@googlemail.com> <50588FE8.4070206@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F9E1265B59
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 14:15:53 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so538701wey.38
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 05:15:53 -0800 (PST)
In-Reply-To: <50588FE8.4070206@googlemail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18/09/12 16:14, Colin Fletcher wrote:
> On 18/09/12 15:47, Colin Fletcher wrote:
>> On 18/09/12 15:23, Clemens Ladisch wrote:
>>> Colin Fletcher wrote:
>>>> I've just recently noticed that connections to the MIDI output
>>>> of my Edirol UA-1000 fail when using the snd_ua101 driver in
>>>> recent kernels.
>>>>
>>>> aconnect simply reports "Connection failed (Input/output
>>>> error)"; a2jmidid -e says "ERROR: a2j_port_create:
>>>> snd_seq_connect_to() for 20:0 failed with error -5"
>>>
>>> Are there any error messages in the system log?
>>>
>>
>> Hi Clemens,
>>
>> Not a squeak in/var/log/syslog or /var/log/messages when I try to
>> connect using aconnect, no. Can you think of anywhere else I might
>> look?
>>
>> Colin.
>
> Just a little more info: 'strace aconnect 20:0 20:0' shows that the
> SNDRV_SEQ_IOCTL_SUBSCRIBE_PORT ioctl on "/dev/snd/seq" is the thing
> which is giving the EIO error.
>


Hello Clemens,

I wondered whether what you said about a problem with the US-122 MIDI 
out [1] was the same problem as mine. with the UA-1000, so I tried 
kernels 2.6.38.8 and 2.6.39.

With kernel 2.6.38.8, aconnect can connect to the MIDI out of my 
UA-1000; with 2.6.39, it fails, so it seems likely that it is the same bug.

Would a bisection between these kernels be useful, or do you have an 
idea already of what might have caused this regression?

Colin Fletcher.


[1] http://www.spinics.net/linux/fedora/alsa-user/msg11499.html
