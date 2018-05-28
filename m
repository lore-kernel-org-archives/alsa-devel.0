From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Echo Audiofire 12 issues
Date: Tue, 29 May 2018 07:23:15 +0900
Message-ID: <a1ceb237-cafa-e2d4-7ac4-f4936c98fa74@sakamocchi.jp>
References: <1527458701.3272.0@smtp.gmail.com>
 <672c8a05-ead2-221a-5430-f071ee208d25@sakamocchi.jp>
 <1527515729.2126.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id AD770267252
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 00:23:21 +0200 (CEST)
In-Reply-To: <1527515729.2126.0@smtp.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adriano Michael Petrosillo <ampetrosillo@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 28 2018 22:55, Adriano Michael Petrosillo wrote:
> When I start Ardour, for example, which employs the ALSA driver 
> (optionally through JACK), it is able to employ the audio interface for 
> a while but this will invariably and eventually result in a string of 
> buffer under-runs, at which point the DAW automatically disengages from 
> using the audio interface. Any attempt to reconnect to the interface 
> results in a segfault. I realise this may appear to be a fault in Ardour 
> itself but there are no such issues with the regular onboard interface. 
> If you want I can run some tests, but you'll have to guide me through it.

Hm. Please explain about the reason that you judge this issue comes from 
ALSA fireworks driver somewhat. Did you compare behaviours of the other 
application such as aplay, pulseaudio and so on?


Regards

Takashi Sakamoto
