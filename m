From: "Nick French" <nick@greensignal.com>
Subject: Re: Re: Sound on a VIA8235
Date: Thu, 30 Jan 2003 16:21:20 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0ac001c2c87b$a01c5860$36dc10ac@dillon>
References: <3E364D4F.6060003@mpi-magdeburg.mpg.de> <s5hhebtmvre.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all

I have a KV7MM+ board with via8235

I also had the same problem and this does indeed fix it. I changed the
volume in asound.state and did alsactl restore 0

is there anyway to get it so that it is the master volume as aumix and other
applications cannot change the volume now.

any mapping file I can change so that Headphone becomes master.

Thanks for the info so far I was scratching my head on this for while.

Cheers

Nick

----- Original Message -----
From: "Takashi Iwai" <tiwai@suse.de>
To: "Martin Haefele" <haefele@mpi-magdeburg.mpg.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, January 28, 2003 10:08 AM
Subject: [Alsa-devel] Re: Sound on a VIA8235


> Hi Martin,
>
> At Tue, 28 Jan 2003 10:28:47 +0100,
> Martin Haefele wrote:
> >
> > Dear Takashi Iwai,
> >
> > I write to you directly and not via a mailing list, because I already
> > have problems with SPAM and do not want to increase it. Hope that's okay
> > anyway.
>
> doesn't matter, but i add Cc to alsa-devel ML, too, so that other
> people can help you, too.
>
>
> > On the sourceforge pages of the alsa project, I found out that you
> > initiated a call for testers for the above chip on Jan, 9th. And as you
> > suggested in your call, I used the latest CVS version of the
> > alsa-drivers plus the VIA8233[A].conf files.
>
> you don't need VIA8233A.conf, btw.
>
>
> > But the problem is, that I hardly can hear sound coming from the
> > speakers. I unmuted everything, but nothing helped very much. If
> > everything is at 100% and my HIFI volume is at 100% as well, then one
> > can hear sound coming from the speakers if and only if one is standing
> > right in front of them. The hardware is a ASRock K7VT2 with VIA8235
> > Southbridge. All that I could gather as information follows as
attachment.
>
> try to raise and unmute "Headphone" volume.
> it's a kind of bug in alsa driver, because this volume is not really a
> headphone but a "true line-out" volume according to the definition of
> AC97 spec 2.2.
>
>
> Takashi
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
