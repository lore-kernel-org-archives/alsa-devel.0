From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hdsp and midi problems
Date: Mon, 23 Jun 2003 09:58:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEAFCJAB.mknecht@controlnet.com>
References: <s5h3ci03gb8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3ci03gb8.wl@alsa2.suse.de>
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

 > Marcus,
> >    The HDSP 9652 MIDI interface has (for me under Linux) always
> dropped lots
> > of notes. Mostly I find it interesting that it drops note off
> information
> > and doesn't seem to drop note-on. I cannot be sure how well it handles
> > controller information.
>
> do you mean dropping notes in reading MIDI?
> well, IIRC, you reported also that the behavior of MIDI out is
> strange...  oh sigh.

Yes, but I tested Alsa (a long time ago) with both MIDI-IN driving soft
synths, and then MIDI-IN/MIDI-OUT driving hardware synths and got the same
'note stuck on' problem. For that reason I say it's a 'MIDI-IN dropped note'
problem, but certainly I do not know this for sure.

>
> dropping a note is surely a bug of the driver.
> unless the FIFO overflows, no dropping should happen.
>
> btw, could you try the attached patch?
> (and in-advance-scheduled excuse if it causes a hang-up :)
>

I would be happy to try a bit of patching. However, I am on
Redhat/PlanetCCRMA and Gentoo, both of which provide prebuilt Alsa
environments. I can try patching the Gentoo one which is pretty recent, but
it may take a few days before I can get back to you.




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
