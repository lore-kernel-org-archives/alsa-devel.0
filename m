From: Xavier ALLAMIGEON <xavier.allamigeon@libertysurf.fr>
Subject: Re: ymfpci : four speakers with OSS-emulation
Date: Thu, 14 Mar 2002 19:22:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a6qsvn$et0$2@main.gmane.org>
References: <1016112652.3c90a60c61558@imp.free.fr> <s5h1yenjd6w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received: from mail.libertysurf.net (mail.libertysurf.net [213.36.80.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA32371
	for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2002 19:19:56 +0100
In-Reply-To: <s5h1yenjd6w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm sorry, but my .asoundrc work very fine for me.
O.K. for tux racer, I have understood. XMMS works fine with aoss, that's=20
great !
And for the application which use mmap, there is no solution, isn't it ?

Le Jeudi 14 Mars 2002 18:01, vous avez =E9crit :
> At Thu, 14 Mar 2002 14:30:52 +0100 (MET),
>
> xavier.allamigeon@free.fr wrote:
> > Cool, it works with aplay ! But the .asoundrc isn't right, you have t=
o
> > change it :
> > pcm.ch4dup {
> >              type plug
> >              slave.pcm surround40
> >              ttable.0.0 1
> >              ttable.0.1 1
> >              ttable.0.2 1
> >              ttable.0.3 1
> >      }
> > and then
> > aplay -D ch4dup foo.wav will play the sound on the four speakers !!!
>
> no, this will route only the left channel to all 4 speakers..
>
> > Otherwise, I have tried aoss, and it doesn't work. Of course, I have
> > added the following line to the .asoundrc file
> > pcm.dsp0 pcm.ch4dup
> > and then I have tried "aoss tuxracer", and there was no sound in the
> > game. But I use the CVS version of alsa-OSS, so maybe there is a bug,=
 I
> > don't know.
>
> if the application needs mmap, this doesn't work.
> i'm not sure whether tux racer requires oss mmap, though.
>
> > Furthermore, why pcm.dsp0 and not pcm.dsp1 or pcm.dsp2 ?
>
> because as default /dev/dsp is mapped /dev/dsp0.
> /dev/dsp1 and dsp2 are for the second and third card.
>
>
> Takashi

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
