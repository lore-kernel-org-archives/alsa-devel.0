From: Ken Arromdee <arromdee@rahul.net>
Subject: Re: Is there any chance of getting my card to work?
Date: Wed, 13 Feb 2002 19:35:36 -0800 (PST)
Message-ID: <Pine.BSF.4.21.0202131918270.71186-100000@yellow.rahul.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from yellow.rahul.net (postfix@yellow.rahul.net [192.160.13.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA09157
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2002 04:35:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by yellow.rahul.net (Postfix) with ESMTP id 788AA7E8A
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 19:35:36 -0800 (PST)
In-Reply-To: <s5hu1sl48fi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Feb 2002, Takashi Iwai wrote:
> > If I play a sound file (.wav in this case) using aplay, the file plays, but
> > when it finishes I get an extra repeated bit of sound, just a fraction of a
> > second long.
> hmm, i don't figure out this yet.

I tried regular "play" (the one with sox).  It worked and didn't give me the
problem.  Only aplay does that.  I wonder if the ad1816a driver is really okay
and it's just aplay that's wrong.

> > Also, when I do "playmidi -e", it plays for the right length of time and
> > gives no error messages, but produces no sound.  I have a midi daughterboard
> > attached to my card; it worked fine in Alsa 0.5 and it works in Windows 98.
> > "playmidi -f" *does* work, but that's FM.
> > I have no idea whether midi not working is because oss emulation isn't working
> > or whether it's not working even just in Alsa.  I have no Alsa midi player
> > that I can test.  (There's a program in alsa-driver/test/playmidi1, but
> > that just tells me "This player does not support merging of tracks.")
> please check /proc/asound/card/0/midi0 whether the status is changed
> during playback.

The status is not changed during playback and it still says Tx bytes  :0.

Where's the simplest Alsa midi player I can get?

> (i suppose that your daughterboard is connected mpu401.)
> also you should check the counter in /proc/interrupts and whether irq
> 9 (for mpu401) is really generated.

  9:          1          XT-PIC  MPU401 UART

The number goes up by 1 every time I stop and restart Alsa.

Somehow, playmidi -e just started working right now, for no reason at all.  I
didn't do anything unusual.  It continued working until I stopped Alsa and
started it again, and then it stopped working again.  I can't get it to work
any more.

When it was working the number in /proc/asound/card0/midi0 went up a lot.
The number in /proc/interrupts didn't go up.  I think that there are only
supposed to be interrupts for input, not for output, so this is probably right.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
