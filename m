From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: Echo Canceler with ALSA
Date: Wed, 17 Mar 2004 21:47:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403172147.07333.pwk.linuxfan@gmx.de>
References: <07583ab7a2310faf5c3a330294b7159e@www3.mail.post.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <07583ab7a2310faf5c3a330294b7159e@www3.mail.post.cz>
Content-Disposition: inline
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

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 17. M=E4rz 2004 20:22 schrieb jcep@post.cz:
> Hi everyone,
>
> my diploma project is to develop an echo canceler for controlling
> application with speech. For this purpose, I need to know what a
> sound card is  currently playing. I was trying to find out how to
> read the DMA buffer which contains mixed samples prepared to be
> passed to the sound card. Is there any API call to do this? The
> second thing - What is the best way to allow applications to
> access the echo-cancelled microphone input?
>
> Thank a lot
>
> Jan C.

Hi there,

though I cant really answer your questions, you might want to have a look a=
t=20
the speex project ( http://speex.org ), they develop a codec for the=20
compression of speech, and they already have experimental echo cancellation=
=20
routines in their most recent development version...but, as the lead=20
developer puts it:

Am Montag, 9. Februar 2004 08:21 schrieb Jean-Marc Valin:
> Yes, the echo cancellation code is very experimental. The algorithm
> implemented (MDF) is very efficient, but it will *not* work out of the
> box yet. Right now, it's mainly missing a cross-talk detector and some
> tuning of the adaptation rate. I can't give a target date at which the
> code will work, but if someone with echo-cancelling experience
> volunteers to help, it might happen faster.

As you seem to be somebody with experience in the area, maybe you could bui=
ld=20
up your diploma work on speex ?

Just a thought.

Peter
=2D --=20
Quantity is no substitute for quality, but its the only one we've got.
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWLlIg2ieGvTmHiURAl+LAKCCbPkKsclSo3xkuOhS8Z4vrDjBkwCfVzN7
rWxYRXxcMCP1IOjGJnDkp5g=3D
=3DJeR/
=2D----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
