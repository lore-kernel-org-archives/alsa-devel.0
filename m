From: "Denis de Leeuw Duarte" <denis@cyozlab.com>
Subject: Which API for MIDI?
Date: Wed, 10 Dec 2003 10:29:44 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031210092944.0F1A05543@slik.org>
Reply-To: denis@cyozlab.com
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello folks,

I'm starting work on a new midi sequencing app, but I'm a bit confused by
the different API options ALSA offers. I've been reading whatever snippet=
s
I can find on the web, mostly mailing list archives, and if I understand
correctly my options are basically the rawmidi API and the alsa sequencer
API. With the former I must handle all timing myself in user space and
with the latter this is all done by ALSA, is that a correct description o=
r
am I mistaken?

My question is: if my first priority is to have stable, reliable timing
and performance, which API should I choose, taking the current state of
the alsa sequencer code into consideration?

Many thanks in advance to anyone who can shed some light on this.

Regards,

Denis


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
