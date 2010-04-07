From: "Marcus Weigelt" <noize007@gmx.de>
Subject: Re: User-space control elements in ext PCM plugin
Date: Wed, 07 Apr 2010 13:54:33 +0200
Message-ID: <20100407115433.60020@gmx.net>
References: <20100407100104.41190@gmx.net> <hphqhb$839$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D75391037F8
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 13:54:33 +0200 (CEST)
In-Reply-To: <hphqhb$839$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Colin, =


thanks for your answer. In general the pulse plugin does more or less what =
I want - present controls in userspace, right.
But the PulsePlugin actually consists of two plugins, a PCM plugin (pcm_pul=
se.c) and control plugin (ctl_pulse.c). =

As far as I understand, the control events/messages from the user space sli=
ders are directed to the pulse audio server via the ctl_plugin. My question=
 is actually, how to make use of them directly in the pcm plugin?

As I told, a similiar request was done three years ago: =


http://article.gmane.org/gmane.linux.alsa.devel/50181

That=B4s where I got the idea of creating the user-space control elements d=
irectly inside of the PCM plugin, or did I get it wrong?

Marcus


-------- Original-Nachricht --------
> Datum: Wed, 07 Apr 2010 12:32:59 +0100
> Von: Colin Guthrie <gmane@colin.guthr.ie>
> An: alsa-devel@alsa-project.org
> Betreff: Re: [alsa-devel] User-space control elements in ext PCM plugin

> 'Twas brillig, and Marcus Weigelt at 07/04/10 11:01 did gyre and gimble:
> > Hi,
> > =

> > I=B4m having an external PCM plugin that should do some processing on
> > the audio. That part works fine. Now I=B4d like to have some way to
> > modify the way to give some parameters to the plugin to tell it how
> > the processing is done (eg. set delay time, pan, attack time, ...). =

> > I=B4ve searched the web for days and hours, but could not really find
> > something. On the alsa mailing list there was a similiar question
> > three years ago, and the answer was, that one could create user-space
> > control elements in the plugin. How is that done? I could not find
> > examples or good documentation about it. Did I miss something out?
> > Can anyone give me a hint, maybe a link to some docs about it or
> > source of a PCM plugin creating/using user space control elements?
> > Thanks a lot.
> =

> Try looking at the PulseAudio plugin. It presents userspace sliders to
> control the volume. If I've not misunderstood your request this should
> do what you need.
> =

> Col
> =

> -- =

> =

> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
> =

> Day Job:
>   Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
>   Mandriva Linux Contributor [http://www.mandriva.com/]
>   PulseAudio Hacker [http://www.pulseaudio.org/]
>   Trac Hacker [http://trac.edgewall.org/]
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
