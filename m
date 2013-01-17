From: Rene Herman <rene.herman@gmail.com>
Subject: Re: libao problem (Re: No dmix/dsnoop on Intel ICH4/5
 by default?)
Date: Thu, 17 Jan 2013 13:44:44 +0100
Message-ID: <50F7F23C.4070006@gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
 <50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.gn.mail.iss.as9143.net (smtpq1.gn.mail.iss.as9143.net
 [212.54.34.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C12C2650BD
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 13:44:51 +0100 (CET)
In-Reply-To: <50F7EAA1.7040504@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org
List-Id: alsa-devel@alsa-project.org

On 17-01-13 13:12, Clemens Ladisch wrote:

> Rene Herman wrote:

>> I can mix as many streams as I want using just "aplay" but if I start
>> by playing one track with "ogg123" (which uses a default, unconfigured
>> libao as its backend), I can't start a second ogg123, which then says:
>>
>> ao_alsa WARNING: Unable to open surround playback.  Trying default device...
>
> The default dmix is for stereo only.  For a surround dmix device, you'd
> have to write your own definition.

Thank you. I didn't notice it was related due to the "trying default 
device" which I thought should've worked but the issue is that libao 
1.1.0 doesn't use the alsa "default" device by default. The first ogg123 
instance therefore keeps things busy.

There's a matching bug-rapport here, I see:

https://trac.xiph.org/ticket/1776

I can, now, set it to dev=default manually but what this means is that 
libao-1.1.0 by default kills alsa default software mixing. These days 
everybody seems to have regressed to using a soundserver again anyway 
and as such not many may notice, but this izz no good, I feel... :-/

In any case, hope this was useful to alsa-devel in the sense that this 
libao behavior is now known here, but this is otherwise libao related 
only, then.

Regards,
Rene
