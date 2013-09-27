From: Meelis Roos <mroos@linux.ee>
Subject: Re: usb-audio mic problem with Polycom C100S
Date: Fri, 27 Sep 2013 16:36:20 +0300 (EEST)
Message-ID: <alpine.SOC.1.00.1309271623360.1451@math.ut.ee>
References: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
 <52458079.3090809@ladisch.de> <alpine.SOC.1.00.1309271608540.1451@math.ut.ee>
 <524584BF.5040908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee [193.40.5.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E5C326574B
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 15:36:21 +0200 (CEST)
In-Reply-To: <524584BF.5040908@ladisch.de>
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

> Meelis Roos wrote:
> >>> I tried to use Skype (4.1) with Polycom Communicator C100S. Audio
> >>> output works fine but mic seems to be dead, although it is set to
> >>> capture and volume is even max.
> >
> > Simple mixer control 'Mic',0
> >   Limits: Capture 0 - 64
> >   Mono: Capture 0 [0%] [0.00dB] [on]
> 
> This is at the lowest setting.

But this is not changable - at least in alsamixergui???

Played around some. It can be changed from ncurses alsamixer and kmix - 
but it drops to 0 or almost 0. Unchecked skype setting of automatically 
adjusting sound controls, still the same. It still drops to 0 as soon as 
skype call starts.

Aha, changed the skyope checkbox before chaning mic to Communicator, and 
applied the settings - now the mic volume is at max and stays there 
during the call, still no sound.

With volume at 100%, I tried arecord, it sill gets silence. It outputs 
constant stream ox 0x80 bytes.

-- 
Meelis Roos (mroos@linux.ee)
