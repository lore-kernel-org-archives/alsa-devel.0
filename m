From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: Re: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 20:21:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CE155BC.764E5F8F@folkwang-hochschule.de>
References: <E177cnG-0003WZ-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> =

> >Thank you for your prompt reply!
> >
> >However, this is the first time ever I tried using the CVS, so I had n=
o
> >files hanging around prior to this downloading. I am also pretty sure
> >that I downloaded the stuff with -P flag (I did it as instructions on
> >the alsa-project page have stated it, including the -P flag). On top o=
f
> >that I even tried updating the whole CVS tree just to see if that will=

> >fix it.
> >
> >So, I am not sure why it is even referencing the file in the first pla=
ce
> >if none of the other files are supposed to mention it.
> >
> >Should I uninstall every trace of Alsa from my cpu before trying to us=
e
> >CVS?
> =

> No, thats not the issue. It might be a CVS sync issue at sf.net, as
> well. The "anonymous" CVS repository is sometimes 6hrs behind the
> "login" CVS repository.

fyi: the offending file is still in anonymous cvs at =

Tue May 14 18:20:38 UTC 2002

i nuked my tree and did a fresh checkout.

regards,

j=F6rn


> rme9652_mem.c is now in the "Attic" meaning that it was removed from
> CVS:
> =

> pbd[987]>cvs -z3 status rme9652_mem.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> File: no file rme9652_mem.c             Status: Up-to-date
> =

>    Working revision:    No entry for rme9652_mem.c
>    Repository revision: 1.8     /cvsroot/alsa/alsa-kernel/pci/rme9652/A=
ttic/rme9652_mem.c,v
> pbd[988]>
> =

> This means that if you checkout ALSA, you should not get this file. I
> would suggest that try
> =

>  cvs -z3 update -dP
> =

> again, and see if that removes the file.
> =

> --p

--
Watch out where the huskies go and don't you eat
the yellow snow !
	- Frank Zappa

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
