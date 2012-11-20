From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: speaker volume gets down to 0 and muted upon boot
Date: Tue, 20 Nov 2012 18:11:11 +0100
Message-ID: <k8gdjd$cpd$2@ger.gmane.org>
References: <k88fi0$svo$1@ger.gmane.org> <k88h5p$9l9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEF02615F7
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 18:14:58 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TarPc-0003qy-7d
 for alsa-devel@alsa-project.org; Tue, 20 Nov 2012 18:15:04 +0100
Received: from 178-83-207-35.dynamic.hispeed.ch ([178.83.207.35])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 18:15:04 +0100
Received: from belegdol by 178-83-207-35.dynamic.hispeed.ch with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 18:15:04 +0100
In-Reply-To: <k88h5p$9l9$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W dniu 17.11.2012 18:23, Julian Sikorski pisze:
> W dniu 17.11.2012 17:55, Julian Sikorski pisze:
>> Hi,
>>
>> I have recently noticed this annoying phenomenon: the speaker volume
>> will get to 0 and muted way more often than I'd like.
>> I still have not figured out a 100 % reproducer but this is quite
>> annoying. My system specs:
>> 	
>> pulseaudio-1.1-9.fc17.x86_64
>> alsa-lib-1.0.26-1.fc17.x86_64
>> kernel-3.6.6-1.fc17.x86_64
>> http://www.alsa-project.org/db/?f=1707d0e40a7a1df7edc71c6c61dcae41e41a8acb
>>
>> I am eager to receive info on how to debug this further.
>>
>> Best regards,
>> Julian
>>
> Well, it was easier than I thought. Volume=0 and muted is the state the
> machine boots in.
> 
> Julian
> 
It was pulseaudio's fault, sorry for the noise.

Julian
