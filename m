From: Sergei Steshenko <steshenko_sergei@list.ru>
Subject: QEMU + Mepis 3.4.3 + Skype
Date: Wed, 22 Mar 2006 12:46:41 +0200
Message-ID: <20060322124641.4fc37798@comp.home.net>
References: <1142983954.4532.189.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1142983954.4532.189.camel@mindpipe>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Mar 2006 18:32:33 -0500
Lee Revell <rlrevell@joe-job.com> wrote:

> I am afraid the well known Skype+aoss problems may be unfixable from the
> ALSA side. It appears that the Skype binary is self modifying and takes
> extensive measures to make sure it is not being run in a debugger or
> emulator. This almost certainly would eliminate any LD_PRELOAD hacks
> from working.
> 
> http://www.secdev.org/conf/skype_BHEU06.handout.pdf [^]
> 
> I believe the only solution to get Skype working with dmix etc. is for
> the Skype developers to add proper native ALSA support.
> 
> Lee
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
> 

Lee,

I am specifically addressing the "to make sure it is not being run in a debugger or
emulator" statement.

It took a while and some non-default boot options, but I managed to:


1) start QEMU and boot from CD Mepis 3.4.3 ;
2) inside (QEMU + Mepis 3.4.3) to invoke Skype (comes with the Mepis CD);
3) register a new account with Skype;
4) hear the echo123 test message and recorded message of mine.

The machine should be faster than mine (the sound is choppy, I didn't
try to give QEMU higher than default priority), but I think thanks to QEMU
Skype is debuggable/traceable.

Skype continues working after I make a pause in QUEMU emulation.

During the pause one can dump/examine memory, registers, etc.

Skype itself worked out of the (KDE GUI) box.

Regards,
  Sergei.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
