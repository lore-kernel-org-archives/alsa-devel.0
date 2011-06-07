From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: asoc: no valid backend routes for PCM: SDP4430
	Media
Date: Tue, 7 Jun 2011 12:59:10 -0700 (PDT)
Message-ID: <307164.60382.qm@web161713.mail.bf1.yahoo.com>
References: <4DEDE38B.2040408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com
	(nm3-vm0.bullet.mail.bf1.yahoo.com [98.139.212.154])
	by alsa0.perex.cz (Postfix) with SMTP id CBE1A245A9
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 21:59:12 +0200 (CEST)
In-Reply-To: <4DEDE38B.2040408@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam,

Actually, I could not prove DMIC on OMAP4 blaze board is working in both ke=
rnel 2.6.35 and 2.6.38 using arecord and gstreamer-alsa.

In 2.6.35, arecord returns 44 bytes with read error
In 2.6.38, arecord collects native data.

Gstreamer-alsa could not get voice after turning off analog captures using =
amixer. =


Any information regarding DMIC on OMAP4? I see people send DMIC patch to 2.=
6.38.

Please advise.

---henry

--- On Tue, 6/7/11, Liam Girdwood <lrg@ti.com> wrote:

> From: Liam Girdwood <lrg@ti.com>
> Subject: Re: [alsa-devel] asoc: no valid backend routes for PCM: SDP4430 =
Media
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
> Date: Tuesday, June 7, 2011, 3:38 AM
> On 07/06/11 01:13, hong zhang wrote:
> > List,
> > =

> > After capturing data from DMIC on OMAP4 blaze board
> with kernel 2.6.38 and save wav data to 38.wav.
> > =

> > But aplay complains "no valid backend routes". See
> following,
> > =

> > $aplay -f dat 38.wav =

> > [=A0 157.167724] asoc: no valid backend routes for
> PCM: SDP4430 Media
> > aplay: main:654: audio open error: Invalid argument
> > =

> =

> This means you have not configured an audio route for
> playback (i.e. the audio is not routed anywhere from pcm
> hw:0,0). Use alsamixer and configure the kcontrols to define
> the audio path. The kcontrol mappings to audio paths are
> detailed here for OMAP4 :-
> =

> http://omappedia.org/wiki/Audio_Drive_Arch
> =

> Liam
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
