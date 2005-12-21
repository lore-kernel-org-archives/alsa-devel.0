From: laugeo2@free.fr
Subject: Re: Ameter plugin : looping sound
Date: Wed, 21 Dec 2005 23:29:16 +0100
Message-ID: <1135204156.43a9d73c43032@imp3-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A8FE51B6
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 23:29:17 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: rlrevell@joe-job.com
List-Id: alsa-devel@alsa-project.org

> >Hi,
> >Ameter  is a metering plugin for Alsa :
> >http://laugeo.free.fr/ameter.html
> > It stopped working since 1.0.10,and also fails with 1.0.11rc1 (was ok=
 with
> >1.0.9) :
> >Playing a sound with aplay (or any other program) cause  a short sound
looping
> >in audio out ,while  peakmeter displays the real soundfile level .
> > It seems that the looping sound is the end of the last played sound .
> > I have Mandriva 2005 (2.6.11 standard kernel),  ens1371 sound card.
> >Somenone else has reported the problem ( I don't know his config) .
> >
> >Test command:
> >aplay -D ameter sound.wav -v
> >It returns no error.

>The easiest solution is to use ALSA CVS to do a binary search and find
>out exactly which commit broke it.
>
>I like to go by date as not all releases get tagged in CVS:
>
>cvs update -D2005-11-01 -A
>etc
>Lee

It is ok on 2005-09-02 and broken on 2005-09-03
Changing only alsa-lib  makes the problem to appear.

The files that are updated between 09-02 and 09-03:
U alsa-lib/src/pcm/pcm_file.c
U alsa-lib/src/pcm/pcm_generic.c
U alsa-lib/src/pcm/pcm_generic.h
U alsa-lib/src/pcm/pcm_local.h
U alsa-lib/src/pcm/pcm_mmap.c
U alsa-lib/src/pcm/pcm_null.c
U alsa-lib/src/pcm/pcm_plug.c
U alsa-lib/src/pcm/pcm_rate.c
U alsa-lib/src/pcm/pcm_softvol.c

May be it is enough for you, or I can search more exactly
which file(s) are bad for the meter.
Regards

Laurent


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
