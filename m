From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: Problem opening default device in haswell system
 using aplay
Date: Fri, 24 May 2013 23:50:58 +0100
Message-ID: <519FEED2.3020200@citrix.com>
References: <519CE8EA.3010303@citrix.com>
 <CAN8cciZ6UMdCJ=5aetG50xpcoDwpqQySmuxJGdYcFY+uhZPQ=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 485FD265243
 for <alsa-devel@alsa-project.org>; Sat, 25 May 2013 00:46:21 +0200 (CEST)
In-Reply-To: <CAN8cciZ6UMdCJ=5aetG50xpcoDwpqQySmuxJGdYcFY+uhZPQ=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/24/2013 03:18 AM, Raymond Yau wrote:
>
> >
> > I am working on some haswell systems running Ubuntu 12.04 and I have 
> a problem if I run aplay -D sysdefault.
> >
> > when I do:
> >
> > cat /proc/asound/pcm
> >
> > I get:
> >
> > 00-03: HDMI 0 : HDMI 0 : playback 1
> > 00-07: HDMI 1 : HDMI 1 : playback 1
> > 00-08: HDMI 2 : HDMI 2 : playback 1
> > 01-00: ALC662 rev3 Analog : ALC662 rev3 Analog : playback 1 : capture 1
> > 01-02: ALC662 rev3 Analog : ALC662 rev3 Analog : capture 1
> >
> > If I do:
> >
> > aplay -L | grep sysdefault
> >
> > I get:
> >
> > sysdefault:CARD=PCH
> >
> > where PCH is card number 1 (id = 1)
> >
> > on most of my systems (non haswell laptops) the default card is number 0
> >
> > If I run
> >
> > aplay -D sysdefault
> >
> > I get:
> >
> > ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_open) unable to open slave
> > aplay: main:682: audio open error: No such file or directory
> >
> > if I strace it I get:
> >
> > open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 ENOENT (No
> > such file or directory)
>
> defaults.pcm.dmix.device defaults.pcm.device
>
> You have to change defaults.pcm.dmix.device to the device of your hdmi 
> if your are not using the analog device 0
>
The problem I have is that the analog device is on card 1 as cat 
/proc/asound/pcm is showing:

 > 00-03: HDMI 0 : HDMI 0 : playback 1
 > 00-07: HDMI 1 : HDMI 1 : playback 1
 > 00-08: HDMI 2 : HDMI 2 : playback 1
 > 01-00: ALC662 rev3 Analog : ALC662 rev3 Analog : playback 1 : capture 1
 > 01-02: ALC662 rev3 Analog : ALC662 rev3 Analog : capture 1
