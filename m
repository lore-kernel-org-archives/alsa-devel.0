From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: LiveDrive MIDI
Date: Mon, 15 Dec 2003 22:37:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S18966AbTLOUhP/20031215203716Z+11325@nic.funet.fi>
References: <S19912AbTLIUCX/20031209200223Z+9280@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <S19912AbTLIUCX/20031209200223Z+9280@nic.funet.fi> (message from
	Juhana Sadeharju on Tue, 9 Dec 2003 22:02:23 +0200)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello. The case is closed!

Both LiveDrive MIDI and InfraRed remote started working by
following change in modules.conf:
  old: enable_ir
  new: enable_ir=1

Now that I know it the fix seems to be obvious, but in my mail
archives both versions are used.

The Alsa documentation, of course, could be written more clearly.
I must have believed that "enable_ir" is used in similar
manner than C defines, i.e., it is enough if "enable_ir" is
written there.

Funny, to get MIDI working, I had to enable InfraRed remote control!
There could be a "enable_midi" option as well (if any switch is really
needed at all).

Both MIDI and IR remote control are on "hw:0,0". There are no
separate ports for them. But because IR remote data looks always
like this
 F0 00 20 21 60 00 01 0A 41 44 51 2E F7
and MIDI data like this
 90 41 7F
    39 7F
the common port is no a big problem.

Regards,
Juhana


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
