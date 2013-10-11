From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Recording devices opened mono still sending stereo
 causing corrupt audio
Date: Fri, 11 Oct 2013 19:04:54 +0200
Message-ID: <52582FB6.6090006@ladisch.de>
References: <52575722.7060208@mixxx.org> <5257F01D.3040908@ladisch.de>
 <201310111645.53569.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 65E4D261A33
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 19:05:10 +0200 (CEST)
In-Reply-To: <201310111645.53569.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Portaudio List <portaudio@music.columbia.edu>, mixxx-devel <mixxx-devel@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> On Friday 11 October 2013 13:33, Clemens Ladisch wrote:
>> Sean M. Pappalardo - D.J. Pegasus wrote:
>>> the problem occurs when PA is asked to open just one channel of
>>> a sound input device yet the device seems to stream two anyway.
>>
>> Many devices do not support mono streams.
>
> Do USB devices typically not support mono, or is it various, by specific unit?

Many USB device do support mono (especially those with microphones).

It is all motherboard devices that do not support mono.

> However, shouldn't the Alsa default device allow a mono stream to be opened on
> a stereo-only device?

Yes, the device named "default" allows this.

What is PA's default device name?


Regards,
Clemens
