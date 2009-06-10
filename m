From: sandip gangakhedkar <sandipfloyd@gmail.com>
Subject: Re: no sound in ubuntu 8.10 on AD1986 sound card
Date: Wed, 10 Jun 2009 23:51:02 +0530
Message-ID: <6208da1a0906101121h1197a2dfw75ddf489094e48db@mail.gmail.com>
References: <6208da1a0906100917y11b401d8y378af8d7d28e762d@mail.gmail.com>
	<s5hd49ckm2k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id E28A810382A
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 20:23:39 +0200 (CEST)
Received: by yxe34 with SMTP id 34so20604yxe.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 11:22:13 -0700 (PDT)
In-Reply-To: <s5hd49ckm2k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

That's quite inconvenient since I'll have to install a fresh version of
Ubuntu..if that is the case I might as well just reinstall Ubuntu! I think
the problem is in pulseaudio..I hope it is possible to debug based on the
info provided.

Thanks.

On Wed, Jun 10, 2009 at 11:28 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 10 Jun 2009 21:47:34 +0530,
> sandip gangakhedkar wrote:
> >
> > Hi all,
> >
> > I am facing a very perplexing issue with sound in Ubuntu 8.10 which I
> have
> > never encountered before with linux. I do not hear any sound from my
> > speakers. The sound card is AD 1986 (Analog Devices) and it worked
> > wonderfully without any hiccups before on 8.10 and other Ubuntu versions.
> >
> > My alsa-info script is here:
> >
> http://www.alsa-project.org/db/?f=7f34b4e28d97178d7f709740f91ff66ea08a9468
> >
> > I suspect pulseaudio is the culprit:
> > Output of : /var/log/syslog | grep pulseaudio is here:
> > http://paste.ubuntu.com/192629/
> >
> > Running : speaker-test -c2 -D hw:0,0 -t wav -l1 gives no sound.
> >
> > My motherboard is ASUS A8N-VM on a AMD 64 Athlon 3200 Desktop PC.The
> sound
> > card is detected so no problems there.
> >
> > I have reinstalled ALSA, pulseaudio and all the related packages but to
> no
> > avail.
> >
> > I am pretty sure this is not a problem of inadeuate support because sound
> > was working before without any issues.
> >
> > Any ideas/suggestions on how to fix this problem will be greatly
> > appreciated. I am also raising an email bug report at alsa-devel so
> anyone
> > can canter around there and provide expert help :)
>
> Getting alsa-info.sh on the working version to compare with the
> non-working one would be really helpful to find out the difference.
> Adjust the mixer in the same level as much as possible.
>
>
> Takashi
>



-- 
Sandip Gangakhedkar
Mobile:+91-97396-99916
Office: +91-080-2601-4777
Profile: http://www.linkedin.com/in/sandipg
