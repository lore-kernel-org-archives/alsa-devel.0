From: Guido Trentalancia <guido@trentalancia.com>
Subject: Re: Hercules P32 DJ: severe sound distortion during
 MIDI transfers
Date: Fri, 22 Mar 2019 23:04:24 +0100 (CET)
Message-ID: <1263893544.64832.1553292264324@pim.register.it>
References: <1553114844.12865.6.camel@trentalancia.com>
 <1335514032.30698.1553207267014@pim.register.it>
 <s5hr2azp9t3.wl-tiwai@suse.de>
 <D5E663E4-9118-4CA3-8ADE-5F97202D9404@trentalancia.com>
 <s5himwbb5h4.wl-tiwai@suse.de>
 <53EC51B6-618E-47B4-95E8-B24BECEEBC98@trentalancia.com>
 <s5hef6zb4k6.wl-tiwai@suse.de> <1553262288.26146.4.camel@trentalancia.com>
 <s5htvfv9d9z.wl-tiwai@suse.de>
 <AF692377-8E9F-4483-81EC-712B31526DE4@trentalancia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmailsmtp.register.it (webmailsmtp38.register.it
 [195.110.123.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E49E5F8076F
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 23:04:25 +0100 (CET)
In-Reply-To: <AF692377-8E9F-4483-81EC-712B31526DE4@trentalancia.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Update on affected kernels...

> Il 22 marzo 2019 alle 15.54 Guido Trentalancia <guido@trentalancia.com> ha scritto:
> 
> 
> As already explained, I have tested the following kernels:
> 
> - kernel 5.0.2 -----> BROKEN
> - kernel 4.17.10 --> BROKEN
> - kernel 4.12.9 ---> BROKEN

kernel 3.8.13 is also BROKEN (on the system where it fails, not the other one obviously).

On kernel 3.0.0 it is broken even when MIDI is not running.

So, it affects virtually all kernels...

> So, it's been around for very long.
> 
> What do you suggest doing?
> 
> I have found reports on the web about similar problems (with other audio interfaces) with kernels>3.0.0.

Regards,

Guido
