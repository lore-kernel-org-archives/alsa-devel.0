From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Fri, 25 Jan 2013 00:21:30 +0100
Message-ID: <1359069690.2193.0.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org> <1326884040.18308.6.camel@yoyo4>
 <4F3926E3.1050809@drcomp.erfurt.thur.de> <1337260874.2077.6.camel@yoyo5>
 <50E02EE9.3040809@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E42261703
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 00:21:33 +0100 (CET)
Received: by mail-ee0-f54.google.com with SMTP id c41so5043202eek.13
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 15:21:33 -0800 (PST)
In-Reply-To: <50E02EE9.3040809@drcomp.erfurt.thur.de>
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

On Son, 2012-12-30 at 13:09 +0100, Adrian Knoth wrote:
> On 05/17/12 15:21, Roman Haefeli wrote:
> 
> > Hi Adrian
> 
> Hi!
> 
> > In the meantime I upgraded my machine to Ubuntu 12.04 which comes with
> > Linux 3.2.0 and alsa 1.0.25. The symptoms are still the same. When I
> > insert the cardbus adapter and load the snd-hdsp module, I get this in
> > dmesg:
> 
> JFTR: Karl Grill has recently provided a patch that fixes the RPM detection.
> 
> I've tested his patch and will submit it within the next two weeks (I'm
> currently on vacation).
> 
> So you might want to check Takashi's tree in mid January or dig up
> Karl's patch from this list.

I applied your last version of the patch to alsa-driver.git, compiled
and installed it. Unfortunately it is still not working for me. This is
what I get when inserting the cardbus interface:

an 24 23:33:22 yoyo5 kernel: [ 1451.479269] ALSA hdsp.c:859 Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
Jan 24 23:33:22 yoyo5 kernel: [ 1451.482343] ALSA hdsp.c:859 Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
Jan 24 23:33:22 yoyo5 kernel: [ 1451.484378] ALSA hdsp.c:724 Hammerfall-DSP: loading firmware
Jan 24 23:33:22 yoyo5 kernel: [ 1451.994222] ALSA hdsp.c:859 Hammerfall-DSP: wait for FIFO status <= 0 failed after 5000 iterations
Jan 24 23:33:22 yoyo5 kernel: [ 1451.994226] ALSA hdsp.c:730 Hammerfall-DSP: timeout waiting for download preparation
Jan 24 23:33:22 yoyo5 kernel: [ 1451.994229] ALSA hdsp.c:5517 >Hammerfall-DSP: couldn't get firmware from userspace. try using hdsploader
Jan 24 23:33:22 yoyo5 kernel: [ 1451.994232] ALSA hdsp.c:5522 >Hammerfall-DSP: card initialization pending : waiting for firmware

I wonder if this might be related to the fact, that almost a year ago I
performed an update of the cardbus firmware (on Windows). Could it be
that this firmware version is simply not supported by ALSA?

Hey, many thanks for your efforts. I'm glad to hear that it is now
working for some people.

Roman
