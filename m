From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: soundcard matrix (more)(
Date: Mon, 01 Dec 2003 08:59:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312011359.hB1Dxraf013635@oud.linuxaudiosystems.com>
References: <s5h1xrobsi2.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 01 Dec 2003 14:02:45 +0100."
             <s5h1xrobsi2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, Peter Enderborg <pme@ufh.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>has anyone contact with yamaha, btw?

i've spoken in person with guys inside the mLAN development group (at
NAMM, last februrary), and they put me in touch with a professor in
south africa who has been acting as a consultant for them on a number
of aspects of mLAN. i talked with him a few times too, he's quite a
fan of linux.

my understanding of the end result of this conversation was that:

   * the core part of mLAN is already part of an IEEE standard
   * the part that Yamaha is retaining right now is the connection
       management stuff. they are not unwilling to release this,
       but they are also not particularly enthusiastic about it
       and nobody knows who has authority to do so. they have
       licensing schemes for this part, but eventually hope to
       see it merged into either the existing IEEE standard
       or a new one.

note: without connection management, mLAN looks like the ALSA
sequencer but without any way to know which ports exist. its not
useless, but its very hard to use.

--p


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
