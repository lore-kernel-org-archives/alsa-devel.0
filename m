From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: RME Fireface alsa driver
Date: Mon, 17 Dec 2018 23:16:45 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1812172247580.1336@laptop>
References: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
 <20181211204344.GA16818@workstation>
 <a61bd3e8-0ace-3ef1-ffa4-f56c3c67fd31@halfshavedyaks.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B39032678D5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 15:16:54 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id a14so6195009plm.12
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 06:16:54 -0800 (PST)
In-Reply-To: <a61bd3e8-0ace-3ef1-ffa4-f56c3c67fd31@halfshavedyaks.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thet <parenthetical@halfshavedyaks.xyz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
(C.C.ed to alsa-devel)

At first, I apologize that ALSA fireface driver since Linux kernel v4.12 
includes some bugs for its packet handling for PCM capture substream[1].
This bug can brings disorder of jackd process.

Furthermore, even if handling rx packets correctly, Fireface 400 cannot 
generate sounds because audio data frame is not picked up from 
isochronous packets to DSP[2].

I've already posted some patches to fix these bugs. The patches were 
already merged to ALSA upstream and they'll be going to mainline in next 
merge window for v4.21 kernel. They were also posted for stable kernel and 
later you can receive patched kernel image if you use any stable kernels.

If you'll test these patches in current your environment, please get 
recent code from my remote repository for backport to Linux v4.17 or later:
https://github.com/takaswie/snd-firewire-improve

Your test will be great help to me because I've already left Fireface 400.
(I rented it just for two weeks and I'll leave Fireface 800 soon as well.)

On Fri, 14 Dec 2018, thet wrote:
> OK I have the FF400 set up now.

In my recent work for Fireface 800[3][4], I ensure that Fireface 800 
can generate sounds even if the HOST LED turns on. This is the same
experience with Fireface 400. Thus you can ignore whether the LED turn off
or not.

> What action should I take to create an error that is meaningful?
> ..
> when I start audacious from the terminal using the alsa output plugin
> and the FF400 selected I get:

Any GUI tools are not necessarily good for debugging. Please use 'aplay' 
insted, like:

$ aplay -v -D hw:Fireface400 -r 44100 -c 18 -f S32_LE /dev/urandom
$ aplay -v -D hw:Fireface400 -r 88200 -c 14 -f S32_LE /dev/urandom
$ aplay -v -D hw:Fireface400 -r 192000 -c 10 -f S32_LE /dev/urandom

In the above cases, I expect your unit can generate noisy sounds with the
latest code of driver.

Anyway, I note you not to drop list address (alsa-devel@alsa-project.org) 
from CC list. It's valuable to share experiences of errors/failures 
because potentially they are good information for developers to seek bugs 
in software and be going to fix them.

[1] [alsa-devel] [PATCH 1/3] ALSA: firewire-lib: fix wrong handling 
payload_length as payload_quadlet
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143147.html
[2] [alsa-devel] [PATCH] ALSA: fireface: fix for state to fetch PCM frames
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143150.html
[3] [alsa-devel] [PATCH 0/8] ALSA: fireface: add support for Fireface 800 
with MIDI functionality only
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/142826.html
[4] [alsa-devel] [PATCH 0/5] ALSA: fireface: add support for Fireface 800 
with streaming functionality
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143154.html


Regards

Takashi Sakamoto
