From: Michael Ulbrich <mul@rentapacs.de>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L - where's
 Waldo?)
Date: Sat, 22 Mar 2003 13:45:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7C5ACC.3D112AB@rentapacs.de>
References: <E18wRlw-0002ZE-00@sc8-sf-list1.sourceforge.net> <1048334386.3e7c503222f73@www2.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
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

Jaakko Pr=E4tt=E4l=E4 wrote:
>=20
> Lainaus Paul Davis <paul@linuxaudiosystems.com>:
>=20
> > mark - i'm not trying to apportion blame, but i would note that if yo=
u
> > had not updated the firmware, this would not have happened. also, i
> > had hoped that takashi or jaroslav would have applied the patches
> > already mailed to the mailing list to CVS, but they chose not for
> > various reasons.
> >
> > i use my H-DSP almost every day, and it works without problems for
> > most things (you know most of the issues).
> [...]
> > i believe that my work and now thomas's will be available very soon,
> > and will make the hdsp a truly phenomenal card under linux.
>=20
> How about if you send a diff of the driver you're using with
> your hdsp with firmware rev 11 against current cvs?
> I've never done it but I could try and build an
> first-aid rpm for Mark and others who want it.
> Unless of course cvs will be up to date very soon.
>=20
> I tried to patch the driver with your patch version II I found
> in the archives but it was very difficult because of the extra
> linefeeds the mail archive had added to the patch. I don't think
> it went right. At least the first hunk I had to edit in by hand
> afterwards. Whatever the reason, my multiface doesn't get
> recognized. It might be my pcmcia setup or (hopefully not)
> the laptop or the card itself. It would be great to have
> less places to look for faults.

<snip>

Hi list,

yeah, I'd like to second what Jaakko asks for.

I did patch the current hdsp.c (rev. 1.26) with Paul's version II patch
and Thomas' spdifFrequency bitmasks fix. After some preliminary
corrections as described above, I'm quite sure that the patch was
applied correctly.

It was not possible to get the firmware rev 11 loaded. During boot the
test for iobox does not recognize the attached Multiface. Manually
loading the driver 'modprobe snd-hdsp' completely freezes the machine.

Preloading the firmware by booting into Windoze helps a bit in that
after loading Linux again and applying a certain combination of card
ejects and reinserts combined with modprobing the driver finally leads
to a stable (?) setup with sound output on the line out jack.

If you decide to post some beta version of the announced mega patch, I'd
like to offer some help in testing and reporting (if time permits, but
over the weekend there's always some ... ;-).

I'd love to see (hear!) the hdsp fully supported under Linux.

Greetings from Berlin ... Michael


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
