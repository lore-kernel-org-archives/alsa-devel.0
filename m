From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Sony VAIO I810 system freeze
Date: Tue, 25 Nov 2003 13:10:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069780248.1588.6.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I just tried to help someone with a Sony VAIO + i810 audio device to
install the latest ALSA driver. As soon as any access to the device
occurs the system freezes. I tried 0.9.8 and 1.0.0pre2; same result.
The OSS driver works, but skips all the time.
The installed OS was SUSE 8.0 (by the way, what an annoyance to install
kernel modules, version mismatch, no kernel headers .....)

Its an VAIO Pentium 4 (very small Notebook). I didn't had the chance to
get a lspci output, sorry.

I haven't take much care about intel810 issues since i don't use such
hardware, but that driver seems to definitely need some stability
improvements.

I hope someone of the intel8x0 guys can take a look and wipe out away
the nitroglycerin.

Best Regards




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
