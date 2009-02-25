From: Clive Messer <clive@vacuumtube.org.uk>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 18:34:31 +0000
Message-ID: <200902251834.31492.clive@vacuumtube.org.uk>
References: <20090219024611.GA7930@tango.0pointer.de>
	<200902251736.24306.clive@vacuumtube.org.uk>
	<s5hocwqcrl0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_38YpJGezNxPnGiE"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from abbey4.objectsoft-systems.ltd.uk
	(abbey4.objectsoft-systems.ltd.uk [87.194.123.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 540A71038D4
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 19:34:32 +0100 (CET)
In-Reply-To: <s5hocwqcrl0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_38YpJGezNxPnGiE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 25 Feb 2009 18:13:47 Takashi Iwai wrote:

> > > diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
> > > index e9ce092..5211d1c 100644
> > > --- a/src/pcm/pcm_hw.c
> > > +++ b/src/pcm/pcm_hw.c
> > > @@ -131,6 +131,10 @@ struct timespec snd_pcm_hw_fast_tstamp(snd_pcm_t
> > > *pcm) static int sync_ptr1(snd_pcm_hw_t *hw, unsigned int flags)
> > > =A0{
> > > =A0=A0=A0=A0=A0=A0=A0=A0int err;
> > > +=A0=A0=A0=A0=A0=A0=A0long old_hwptr, new_hwptr;
> > > +=A0=A0=A0=A0=A0=A0=A0long old_applptr, new_applptr;
> > > +=A0=A0=A0=A0=A0=A0=A0old_hwptr =3D hw->sync_ptr->s.status.hw_ptr;
> > > +=A0=A0=A0=A0=A0=A0=A0old_applptr =3D hw->sync_ptr->c.control.appl_pt=
r;
> > > =A0=A0=A0=A0=A0=A0=A0=A0hw->sync_ptr->flags =3D flags;
> > > =A0=A0=A0=A0=A0=A0=A0=A0err =3D ioctl((hw)->fd, SNDRV_PCM_IOCTL_SYNC_=
PTR,
> > > (hw)->sync_ptr); if (err < 0) {
> > > @@ -138,6 +142,11 @@ static int sync_ptr1(snd_pcm_hw_t *hw, unsigned
> > > int flags) SYSMSG("SNDRV_PCM_IOCTL_SYNC_PTR failed");
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return err;
> > > =A0=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0new_hwptr =3D hw->sync_ptr->s.status.hw_ptr;
> > > +=A0=A0=A0=A0=A0=A0=A0new_applptr =3D hw->sync_ptr->c.control.appl_pt=
r;
> > > +=A0=A0=A0=A0=A0=A0=A0printf("sync_ptr1: %ld(%ld), %ld(%ld)\n",
> > > +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 new_hwptr, new_hwptr - old_hwptr,
> > > +=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 new_applptr, new_applptr - old_app=
lptr);
> > > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > > =A0}
> > > =A0

With sync_ptr I cannot reproduce the very large numbers. Here's a typical l=
og.=20
(Attached).

Regards

Clive
=2D-=20
Clive Messer <clive@vacuumtube.org.uk>


--Boundary-00=_38YpJGezNxPnGiE
Content-Type: text/x-log;
  charset="UTF-8";
  name="sync.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sync.log"

sync_ptr1: 0(0), 0(0)
sync_ptr1: 0(0), 0(0)
sync_ptr1: 0(0), 0(0)
sync_ptr1: 0(0), 0(0)
sync_ptr1: 0(0), 0(0)
sync_ptr1: 0(0), 1(1)
29091	29089	0	4416	0	4	1	2
sync_ptr1: 0(0), 1(0)
sync_ptr1: 0(0), 1(0)
sync_ptr1: 0(0), 2(1)
29102	29102	22	4415	0	4	1	2
sync_ptr1: 0(0), 2(0)
sync_ptr1: 0(0), 2(0)
sync_ptr1: 0(0), 3(1)
29109	29107	45	4414	0	4	1	2
sync_ptr1: 0(0), 3(0)
sync_ptr1: 0(0), 3(0)
sync_ptr1: 0(0), 4(1)
29113	29112	68	4413	0	4	1	2
sync_ptr1: 0(0), 4(0)
sync_ptr1: 0(0), 4(0)
sync_ptr1: 0(0), 5(1)
29116	29116	90	4412	0	4	1	2
sync_ptr1: 0(0), 5(0)
sync_ptr1: 0(0), 5(0)
sync_ptr1: 0(0), 6(1)
29119	29119	113	4411	0	4	1	2
sync_ptr1: 0(0), 6(0)
sync_ptr1: 0(0), 6(0)
sync_ptr1: 0(0), 7(1)
29122	29122	136	4410	0	4	1	2
sync_ptr1: 0(0), 7(0)
sync_ptr1: 0(0), 7(0)
sync_ptr1: 0(0), 8(1)
29125	29125	158	4409	0	4	1	2
sync_ptr1: 0(0), 8(0)
sync_ptr1: 0(0), 8(0)
sync_ptr1: 0(0), 9(1)
29129	29129	181	4408	0	4	1	2
sync_ptr1: 0(0), 9(0)
sync_ptr1: 0(0), 9(0)
sync_ptr1: 0(0), 10(1)
29132	29132	204	4407	0	4	1	2
sync_ptr1: 0(0), 10(0)
sync_ptr1: 0(0), 10(0)
sync_ptr1: 0(0), 11(1)
29135	29135	226	4406	0	4	1	2
sync_ptr1: 0(0), 11(0)
sync_ptr1: 0(0), 11(0)
sync_ptr1: 0(0), 12(1)
29138	29138	249	4405	0	4	1	2
sync_ptr1: 0(0), 12(0)
sync_ptr1: 0(0), 12(0)
sync_ptr1: 0(0), 13(1)
29141	29141	272	4404	0	4	1	2
sync_ptr1: 0(0), 13(0)
sync_ptr1: 0(0), 13(0)
sync_ptr1: 0(0), 14(1)
29145	29144	294	4403	0	4	1	2
sync_ptr1: 0(0), 14(0)
sync_ptr1: 0(0), 14(0)
sync_ptr1: 0(0), 15(1)
29148	29148	317	4402	0	4	1	2
sync_ptr1: 0(0), 15(0)
sync_ptr1: 0(0), 15(0)
sync_ptr1: 0(0), 16(1)
29151	29151	340	4401	0	4	1	2
sync_ptr1: 0(0), 16(0)
sync_ptr1: 0(0), 16(0)
sync_ptr1: 0(0), 17(1)
29154	29154	362	4400	0	4	1	2
sync_ptr1: 0(0), 17(0)
sync_ptr1: 0(0), 17(0)
sync_ptr1: 0(0), 18(1)
29157	29157	385	4399	0	4	1	2
sync_ptr1: 0(0), 18(0)
sync_ptr1: 0(0), 18(0)
sync_ptr1: 0(0), 19(1)
29160	29160	408	4398	0	4	1	2
sync_ptr1: 0(0), 19(0)
sync_ptr1: 0(0), 19(0)
sync_ptr1: 0(0), 20(1)
29163	29163	430	4397	0	4	1	2
sync_ptr1: 0(0), 20(0)
sync_ptr1: 0(0), 20(0)
sync_ptr1: 0(0), 21(1)
29167	29166	453	4396	0	4	1	2
sync_ptr1: 0(0), 21(0)
sync_ptr1: 0(0), 21(0)
sync_ptr1: 0(0), 22(1)
29170	29170	476	4395	0	4	1	2
sync_ptr1: 0(0), 22(0)
sync_ptr1: 0(0), 22(0)
sync_ptr1: 0(0), 23(1)
29173	29173	498	4394	0	4	1	2
sync_ptr1: 0(0), 23(0)
sync_ptr1: 0(0), 23(0)
sync_ptr1: 0(0), 24(1)
29176	29176	521	4393	0	4	1	2
sync_ptr1: 0(0), 24(0)
sync_ptr1: 0(0), 4397(0)
sync_ptr1: 0(0), 4397(0)
sync_ptr1: 0(0), 4398(1)
44834	44833	99705	19	0	0	1	2
sync_ptr1: 0(0), 4398(0)
sync_ptr1: 0(0), 4398(0)
sync_ptr1: 0(0), 4399(1)
44837	44837	99727	18	0	0	1	2
sync_ptr1: 0(0), 4399(0)
sync_ptr1: 0(0), 4399(0)
sync_ptr1: 0(0), 4400(1)
44840	44840	99750	17	0	0	1	2
sync_ptr1: 0(0), 4400(0)
sync_ptr1: 0(0), 4400(0)
sync_ptr1: 0(0), 4401(1)
44843	44843	99773	16	0	0	1	2
sync_ptr1: 0(0), 4401(0)
sync_ptr1: 0(0), 4401(0)
sync_ptr1: 0(0), 4402(1)
44847	44846	99795	15	0	0	1	2
sync_ptr1: 0(0), 4402(0)
sync_ptr1: 0(0), 4402(0)
sync_ptr1: 0(0), 4403(1)
44850	44850	99818	14	0	0	1	2
sync_ptr1: 0(0), 4403(0)
sync_ptr1: 0(0), 4403(0)
sync_ptr1: 0(0), 4404(1)
44853	44853	99841	13	0	0	1	2
sync_ptr1: 0(0), 4404(0)
sync_ptr1: 0(0), 4404(0)
sync_ptr1: 0(0), 4405(1)
44856	44856	99863	12	0	0	1	2
sync_ptr1: 0(0), 4405(0)
sync_ptr1: 0(0), 4405(0)
sync_ptr1: 0(0), 4406(1)
44860	44860	99886	11	0	0	1	2
sync_ptr1: 0(0), 4406(0)
sync_ptr1: 0(0), 4406(0)
sync_ptr1: 0(0), 4407(1)
44863	44863	99909	10	0	0	1	2
sync_ptr1: 0(0), 4407(0)
sync_ptr1: 0(0), 4407(0)
sync_ptr1: 0(0), 4408(1)
44866	44866	99931	9	0	0	1	2
sync_ptr1: 0(0), 4408(0)
sync_ptr1: 0(0), 4408(0)
sync_ptr1: 0(0), 4409(1)
44869	44869	99954	8	0	0	1	2
sync_ptr1: 0(0), 4409(0)
sync_ptr1: 0(0), 4409(0)
sync_ptr1: 0(0), 4410(1)
44873	44872	99977	7	0	0	1	2
sync_ptr1: 0(0), 4410(0)
sync_ptr1: 0(0), 4410(0)
sync_ptr1: 0(0), 4411(1)
44876	44876	100000	6	0	0	1	2
sync_ptr1: 0(0), 4411(0)
sync_ptr1: 0(0), 4411(0)
sync_ptr1: 0(0), 4412(1)
44879	44879	100022	5	0	0	1	2
sync_ptr1: 0(0), 4412(0)
sync_ptr1: 0(0), 4412(0)
sync_ptr1: 0(0), 4413(1)
44888	44888	100045	4	0	0	1	2
sync_ptr1: 0(0), 4413(0)
sync_ptr1: 0(0), 4413(0)
sync_ptr1: 0(0), 4414(1)
44892	44892	100068	3	0	0	1	2
sync_ptr1: 0(0), 4414(0)
sync_ptr1: 0(0), 4414(0)
sync_ptr1: 0(0), 4415(1)
44895	44895	100090	2	0	0	1	2
sync_ptr1: 0(0), 4415(0)
sync_ptr1: 0(0), 4415(0)
sync_ptr1: 0(0), 4416(1)
44898	44898	100113	1	0	0	1	2
sync_ptr1: 3632(3632), 4416(0)
sync_ptr1: 3632(0), 4416(0)
sync_ptr1: 3632(0), 4417(1)
44905	44904	82358	3632	784	0	1	3
sync_ptr1: 3632(0), 4417(0)
sync_ptr1: 3632(0), 4417(0)
sync_ptr1: 3632(0), 4418(1)
44908	44908	82358	3631	785	4	1	3
sync_ptr1: 3632(0), 4418(0)
sync_ptr1: 3632(0), 4418(0)
sync_ptr1: 3632(0), 4419(1)
44912	44912	82358	3630	786	4	1	3
sync_ptr1: 3632(0), 4419(0)
sync_ptr1: 3632(0), 4419(0)
sync_ptr1: 3632(0), 4420(1)
44915	44915	82358	3629	787	4	1	3
sync_ptr1: 3632(0), 4420(0)
sync_ptr1: 3632(0), 4420(0)
sync_ptr1: 4464(832), 4421(1)
44919	44919	101224	3628	-44	4	1	3
sync_ptr1: 4464(0), 4421(0)
sync_ptr1: 4464(0), 4421(0)
sync_ptr1: 4464(0), 4422(1)
44923	44922	101224	4459	-43	4	1	3

--Boundary-00=_38YpJGezNxPnGiE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_38YpJGezNxPnGiE--
