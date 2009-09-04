From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: Patch for au88x0 driver. Fix audacious issue and
	add auto reset in case of hardware ADB ctrl failure.
Date: Fri, 4 Sep 2009 20:26:25 +0200
Message-ID: <21ed1c370909041126x5127c74at18eb8429f247daf9@mail.gmail.com>
References: <21ed1c370909031310i8c899fbw919b033315e15af@mail.gmail.com>
	<4AA0DD97.6010405@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id BB775245B7
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 20:26:26 +0200 (CEST)
Received: by fxm3 with SMTP id 3so888056fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 11:26:26 -0700 (PDT)
In-Reply-To: <4AA0DD97.6010405@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there,

about that hunk, damn it ! I think I deleted that at least a dozen
times, and it still sneaked into the final patch :(
It should not be there.

Best Regards,
Manuel

On Fri, Sep 4, 2009 at 11:27 AM, Daniel Gl=F6ckner<dg@emlix.com> wrote:
> On 09/03/2009 10:10 PM, Manuel Jander wrote:
>> does anybody still have a AU88x0 card ? I know they are quite ancient
>> now, but if anyone could give the attached patch a try ? Would be
>> nice.
>
> I can test an AU8820 on 2.4.37 and, if you wait >9 days, an AU8810 on a r=
ecent
> kernel, but what is this hunk supposed to do?:
>
> --- linux-2.6.30.4_orig/sound/pci/au88x0/au88x0_core.c =A02009-07-31 00:3=
4:47.0000
> 00000 +0200
> +++ linux-2.6.30.4/sound/pci/au88x0/au88x0_core.c =A0 =A0 =A0 2009-09-02 =
00:13:59.4671
> 19172 +0200
> @@ -2800,7 +2804,7 @@
> =A0{
> =A0 =A0 =A0 =A0int a, this_194;
>
> - =A0 =A0 =A0 if ((bits !=3D 8) && (bits !=3D 16))
> + =A0 =A0 =A0 if ((bits !=3D 8) || (bits !=3D 16))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>
> =A0 =A0 =A0 =A0switch (encod) {
>
> Any special tests you want me to do? I don't think I have encountered a "=
Vortex:
> vortex_fifo_set*ctrl fail" message before.
>
> =A0Daniel
>
>
> --
> Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
> Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G=F6ttingen, Germany
> Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
> Gesch=E4ftsf=FChrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055
>
> emlix - your embedded linux partner
>
