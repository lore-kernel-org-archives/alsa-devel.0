From: Christian Esken <c.esken@cityweb.de>
Subject: Re: [PATCH] Re: [Alsa-user] Hercules Gametheater XP (cs46xx)
Date: Mon, 17 Feb 2003 23:29:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302172329.45280.c.esken@cityweb.de>
References: <3E4E98B5.7030409@dsl.pipex.com> <3E4FA142.3010406@cucumelo.org> <s5hlm0fi56l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm0fi56l.wl@alsa2.suse.de>
Content-Disposition: inline
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

Am Monday 17 February 2003 11:15 schrieb Takashi Iwai:
> At Sun, 16 Feb 2003 15:33:38 +0100,
>
> Benny Sj=F6strand wrote:
> > > Sorry, but latest CVS does not work. Sound is still very distorted.
> > > CVS from 2002-12-09 12:00 works well though, which is what I'm using
> > > now :) It is using version 1.37 alsa-kernel/pci/cs46xx/cs46xx_lib.cc.
> >
> > Current CVS still seems to be broken. The hercules_init(...) function
> > will reset the EGPIO's to default state  turning of the amplifier. This
> > patch changes the initialization order calling amplifier_ctrl(...) after
> > mixer_init.
>
> thanks, applied to cvs.

Confirmed - it works on my Hercules GT XP !!! Yippey. :-)))))
This ultimately fixes the "distortion problem" that has been there for
me (and others) all the time since after 0.9.0rc2.

A very very very big thanks from me too, Benny. You have made me
very happy today. This calls for a drink. :-)

Best regards,
          Christian



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
