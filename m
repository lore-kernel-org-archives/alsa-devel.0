From: Wolfgang Woehl <tito@rumford.de>
Subject: Re: position_fix issue / snd-hda-intel / alsa <-> jack
Date: Tue, 12 Feb 2008 17:06:37 +0100
Message-ID: <200802121706.37334.tito@rumford.de>
References: <26670.62.212.109.253.1202065817.squirrel@webmail.nerim.net>
	<200802112222.27634.tito@rumford.de> <s5hbq6mv4yt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 81B051038D0
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 17:06:39 +0100 (CET)
In-Reply-To: <s5hbq6mv4yt.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dienstag, 12. Februar 2008 Takashi Iwai:

> JACK does nothing special but do a very basic full-duplex
> operation. The difference is that you use short period size and
> likely two periods.  So, the position calculation isn't accurate on
> your hardware.  Maybe the positions of playback and capture streams
> differe.  An often used workaround for this kind of problems is to
> use three periods instead.

Takashi, thanks for your explanation. The position_fix=0/jackd problem 
occurs with bigger period sizes too, -p[16..1024] -n2. But: With 
position_fix=0 and -p[16..512] _-n3_ jackd is fine.

Not that I'd understand why but I'm happy there is a workaround. If 
someone knows the how and why of this workaround I'd much appreciate 
to learn it.

> (BTW, this problem really depends on the hardware.  That's why
> there are such a strange module option.  So, don't argue this as if
> it's a general problem.)

Like I said, the jack-devel thread was about 2 specific devices and I 
promise we won't make a big fuss about it :)

Wolfgang
