From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: ALSA-CVS : "delay" in audio with OSS emulation
Date: Fri, 21 Nov 2003 00:18:36 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031121001836.36542.qmail@web40606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I've been noticing this for weeks, and it's still
present in 1.0.0-pre1 (fresh from CVS): using
RealPlayer v8 with OSS emulation, the sound is now
several seconds behind the pictures. I haven't touched
my RealPlayer installation, and there is no such delay
if I use the native OSS drivers instead, so I'm fairly
confident that the problem is with ALSA.

I saw no such problem running xine native ALSA
support.

I have a SB Live! (rev 7) card, and am running
Linux-2.4.22 (SMP).

Cheers,
Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
