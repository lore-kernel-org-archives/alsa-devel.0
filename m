From: Ken Arromdee <arromdee@rahul.net>
Subject: Re: Is there any chance of getting my card to work?
Date: Tue, 12 Feb 2002 19:24:08 -0800 (PST)
Message-ID: <Pine.BSF.4.21.0202121848370.77679-100000@yellow.rahul.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from yellow.rahul.net (postfix@yellow.rahul.net [192.160.13.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA06450
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 04:24:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by yellow.rahul.net (Postfix) with ESMTP id 986B37ECB
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 19:24:08 -0800 (PST)
In-Reply-To: <s5hg046605j.wl@alsa2.suse.de>
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

On Tue, 12 Feb 2002, Takashi Iwai wrote:
> Now the fixes are committed to cvs.
> Could you try the cvs version?

Thanks!  Finally after all this time it works...  almost...  I still have
some problems.

If I play a sound file (.wav in this case) using aplay, the file plays, but
when it finishes I get an extra repeated bit of sound, just a fraction of a
second long.

Also, when I do "playmidi -e", it plays for the right length of time and
gives no error messages, but produces no sound.  I have a midi daughterboard
attached to my card; it worked fine in Alsa 0.5 and it works in Windows 98.
"playmidi -f" *does* work, but that's FM.

I have no idea whether midi not working is because oss emulation isn't working
or whether it's not working even just in Alsa.  I have no Alsa midi player
that I can test.  (There's a program in alsa-driver/test/playmidi1, but
that just tells me "This player does not support merging of tracks.")

I did try putting a debug snd_printk in there and it is telling me that the
MPU port is 0x300 and the IRQ is 9, which seems correct.  cat /proc/isapnp
tells me that the device ADS7181 with port 0x300 and IRQ 9 is active.  cat
/proc/interrupts shows IRQ 9 in use by "MPU401 UART", and cat /proc/ioports
shows me "0300-0301 : MPU401 UART", which all seems okay.

The following is my /etc/modules.conf:

# ALSA native
alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=1
alias snd-card-0 snd-ad1816a

# OSS/Free emulation 
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
