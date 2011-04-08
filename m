From: Valerio tesei <valerio.tesei@gmail.com>
Subject: Re: OT: applying patches (was: [PATCH ALSA HDA 1/1]
 Fix alc662_dac_nid and change 6stack-dig to 5stack-dig)
Date: Fri, 8 Apr 2011 11:47:24 +0200
Message-ID: <BANLkTinG09ikc551jywWUFVdQBKXr4ywiQ@mail.gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>
	<s5h8vvnrjea.wl%tiwai@suse.de>
	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>
	<s5hy63nq12a.wl%tiwai@suse.de>
	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>
	<s5htyeb9180.wl%tiwai@suse.de>
	<BANLkTikVQtpzCNX4W6MxAScMHzx_f6FAeA@mail.gmail.com>
	<BANLkTikhM1i8PK8HC9yN6d8yevx982CwGw@mail.gmail.com>
	<1302254931.7217.8.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D436D103A0A
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 11:47:26 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2503420fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 02:47:25 -0700 (PDT)
In-Reply-To: <1302254931.7217.8.camel@mattotaupa>
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

Sorry for the violation of nettiquete,

I think i misunderstood something, I already know how to patch, I was
thinking that "patch=3Dsomething" was a parameter that I need to pass to
modprobe while loading snd-hda-intel.
Anyway thanks for your polite answer, my italian spirit comes up and made
this OT :)

Thanks,
V.



2011/4/8 Paul Menzel <paulepanter@users.sourceforge.net>

> Dear Valerio,
>
>
> please adhere to the netiquette [1] and use interleaved style [2].
>
>
> Am Freitag, den 08.04.2011, 10:38 +0200 schrieb Valerio tesei:
>
> > I spent a little time reading sound documentation but doesn't find
> anything
> > about how to apply a patch to snd-hda-intel, but it is needed? there is
> no
> > an "patch auto detect"? i enable the patch option in HDA-Intel kernel
> > config, this WE i will study more, Takashi could you please give me
> > documentation about patch applying?
>
> You have to apply the patch file using the following command.
>
>        patch -p1 < /path/to/patch/file
>
> I think Takashi put a diff in his message. Just copy those lines into a
> file and apply it like above from the top source directory.
>
> If you have a patch created using `git format-patch` you can simply
> apply that using `git am /path/to/patch`.
>
> [=85]
>
>
> I hope that helps and I am sorry that I cannot answer the other
> questions.
>
>
> Thanks,
>
> Paul
>
>
> [1] http://en.opensuse.org/openSUSE:Mailing_list_netiquette
> [2]
> https://secure.wikimedia.org/wikipedia/en/wiki/Posting_style#Interleaved_=
style
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
