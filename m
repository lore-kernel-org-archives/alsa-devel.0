From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [FT C400, PATCH RFC,
	v4 00/10] M-Audio Fast Track C400
Date: Fri, 30 Nov 2012 15:06:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211301453320.2669@xoschi>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
 <s5hlidkalpp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 90DEC2602AE
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 15:06:11 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so223352bkc.38
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 06:06:11 -0800 (PST)
In-Reply-To: <s5hlidkalpp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Grant Diffey <gdiffey@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

On Thu, 29 Nov 2012, Takashi Iwai wrote:
> At Wed, 28 Nov 2012 23:55:31 +0100,
> Eldad Zack wrote:
> > 
> > * Incoroprated the feedback from Clemens Ladisch <clemens@ladisch.de>: 
> > Moved the quirks structure to the right place (also in other places, though
> > not strictly required) and removed the "set quirks" log messages.
> > Thanks, Clemens!
> > 
> > * Added a patch to address the regression introduced by commit
> > 947d299686aa9cc8aecf749d54e8475c6e498956 , "ALSA: snd-usb: properly initialize
> > the sync endpoint". I believe there are no other devices that affected by this
> > issue. Opening only the playback stream without first opening the capture
> > stream now works with the C400.
> 
> Thanks.  I applied all patches except for the new one (2/10 usb-audio:
> correct sync ep init).  This patch needs a bit more care, as it
> seems.
> 
> I know it must be fixed for FT C400 but the fix itself is independent
> from others, so I merged others first to the rest work easier.

Thanks! That's great, now I only need to concentrate on this one
issue. I went through your helpful comments and I'll try to work out a
better patch soon and send it for review.
Should I wait with it until the 3.8 merge window closes?

BTW - given that the code is old, isn't it time to slightly change 
these? :)

card.c: *   (Tentative) USB Audio Driver for ALSA
mixer.c: *   (Tentative) USB Audio Driver for ALSA
usbaudio.h: *   (Tentative) USB Audio Driver for ALSA

Cheers,
Eldad
