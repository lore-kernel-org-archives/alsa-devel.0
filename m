From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Quattro MIDI (was: CVS changes, rc4 release in H-9)
Date: Tue, 22 Oct 2002 18:12:07 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210221804560.12054-100000@studcom.urz.uni-halle.de>
References: <3DB56C98.7040205@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA04155
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 18:12:15 +0200
In-reply-to: <3DB56C98.7040205@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> I'm now not able to use the qinit program to initialise the quattro
> device anymore. A check of cat /proc/asound/card2/ yields only these
> files now.
>
> id         midi0      oss_mixer
>
> i.e no stream info. I guess that nix noticed this last week on LAU but I
> haven't updated for a couple of weeks so didn't catch when it happened.

I added a quirk for the MIDI port. (BTW: Does it work?)
It seems the USB subsystem only loads the first id_table entry it finds
for each interface. As a quick fix, remove the Quattro entry from
usbquirks.h, but I'm going to write a patch to use both pcm and MIDI.


HTH
Clemens



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
