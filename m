From: Delusion's Master <delusion_master@hotmail.com>
Subject: Re: Error patching file pcm_native.c
Date: Tue, 22 Sep 2009 20:30:36 +0200
Message-ID: <COL119-W53A8E9E2B5D09ED708B1CE8FDC0@phx.gbl>
References: <COL119-W10102D20FE7215072170378FDC0@phx.gbl>
	<s5hy6o7unx7.wl%tiwai@suse.de> <s5hab0nazdc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s8.col0.hotmail.com (col0-omc3-s8.col0.hotmail.com
	[65.55.34.146]) by alsa0.perex.cz (Postfix) with ESMTP id 9968724485
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 20:30:41 +0200 (CEST)
In-Reply-To: <s5hmy4n9eam.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Date: Tue, 22 Sep 2009 17:42:25 +0200
> From: tiwai@suse.de
> To: delusion_master@hotmail.com
> CC: alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] Error patching file pcm_native.c
> =

> At Tue, 22 Sep 2009 17:23:07 +0200,
> Delusion's Master wrote:
> > =

> > =

> > > Date: Tue, 22 Sep 2009 15:21:51 +0200
> > > From: tiwai@suse.de
> > > To: delusion_master@hotmail.com
> > > CC: alsa-devel@alsa-project.org
> > > Subject: Re: [alsa-devel] Error patching file pcm_native.c
> > > =

> > > At Tue, 22 Sep 2009 15:19:43 +0200,
> > > Delusion's Master wrote:
> > > > =

> > > > =

> > > > > Date: Tue, 22 Sep 2009 15:08:52 +0200
> > > > > From: tiwai@suse.de
> > > > > To: delusion_master@hotmail.com
> > > > > CC: alsa-devel@alsa-project.org
> > > > > Subject: Re: [alsa-devel] Error patching file pcm_native.c
> > > > > =

> > > > > At Tue, 22 Sep 2009 14:39:36 +0200,
> > > > > Delusion's Master wrote:
> > > > > > =

> > > > > > =

> > > > > > Hi,
> > > > > > =

> > > > > > first of all I apologize in case you receive multiple copies of=
 this message, but I forgot to specify a subject in the original mail.
> > > > > > =

> > > > > > I have a problem compiling the latest alsa driver snapshots. Sp=
ecifically, it's a problem when patching pcm_native.c:
> > > > > > =

> > > > > > [..]
> > > > > > copying file alsa-kernel/core/info.c
> > > > > > patching file info.c
> > > > > > copying file alsa-kernel/core/pcm.c
> > > > > > patching file pcm.c
> > > > > > Hunk #3 succeeded at 739 (offset 2 lines).
> > > > > > Hunk #5 succeeded at 954 (offset 2 lines).
> > > > > > Hunk #7 succeeded at 1045 (offset 2 lines).
> > > > > > copying file alsa-kernel/core/pcm_native.c
> > > > > > patching file pcm_native.c
> > > > > > Hunk #4 succeeded at 1544 (offset -25 lines).
> > > > > > Hunk #5 succeeded at 2827 (offset 12 lines).
> > > > > > Hunk #6 succeeded at 2878 (offset 10 lines).
> > > > > > Hunk #7 FAILED at 2906.
> > > > > > Hunk #8 FAILED at 2922.
> > > > > > Hunk #9 succeeded at 2915 (offset -23 lines).
> > > > > > Hunk #10 succeeded at 3036 (offset 10 lines).
> > > > > > Hunk #11 succeeded at 3027 (offset -23 lines).
> > > > > > Hunk #12 succeeded at 3074 (offset 10 lines).
> > > > > > Hunk #13 succeeded at 3098 (offset -23 lines).
> > > > > > Hunk #14 succeeded at 3143 (offset 10 lines).
> > > > > > Hunk #15 succeeded at 3124 (offset -23 lines).
> > > > > > Hunk #16 succeeded at 3214 (offset 10 lines).
> > > > > > Hunk #17 succeeded at 3208 (offset -23 lines).
> > > > > > Hunk #18 succeeded at 3271 (offset 10 lines).
> > > > > > Hunk #19 succeeded at 3304 (offset -23 lines).
> > > > > > Hunk #20 succeeded at 3386 (offset 10 lines).
> > > > > > Hunk #21 succeeded at 3411 (offset -23 lines).
> > > > > > Hunk #22 succeeded at 3456 (offset 10 lines).
> > > > > > Hunk #23 succeeded at 3450 (offset -23 lines).
> > > > > > Hunk #24 succeeded at 3525 (offset 10 lines).
> > > > > > Hunk #25 succeeded at 3644 (offset -23 lines).
> > > > > > 2 out of 25 hunks FAILED -- saving rejects to file pcm_native.c=
.rej
> > > > > > make[2]: *** [pcm_native.c] Error 1
> > > > > > =

> > > > > > =

> > > > > > It's
> > > > > > some days I get this, but I waited to report this since I thoug=
ht it
> > > > > > could be a temporary problem. My OS is Fedora 11 x86_64. Previo=
us
> > > > > > snapshots didn't give me this problem, but I can't say which on=
e broke
> > > > > > the compilation, since I usually try updated snapshots only at =
kernel
> > > > > > updates.
> > > > > > =

> > > > > > I searched for this error and the only relevant report I could =
find is this one:
> > > > > > =

> > > > > > http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April=
/016420.html
> > > > > > =

> > > > > > a report from last April.
> > > > > > =

> > > > > > What could the problem be?
> > > > > =

> > > > > I seem to have overlooked the patch rejection because some patch
> > > > > program is stricter than mine.  Now I refreshed the relevant patch
> > > > > file.   Could you try the latest snapshot below again?
> > > > >   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/als=
a-driver-snapshot.tar.gz
> > > > > =

> > > > > =

> > > > > Takashi
> > > > =

> > > > =

> > > > Hi Takashi,
> > > > =

> > > > thanks for your very quick reply!
> > > > I just tried and I still get the same error -- the same hunks fail =
(7 and 8).
> > > =

> > > Are you sure it's the VERY same error?
> > > Give the exact error messages.
> > > =

> > > =

> > > Takashi
> > =

> > =

> > Here it is:
> > =

> > =

> > [..]
> > patching file pcm.c
> > Hunk #2 succeeded at 925 (offset 15 lines).
> > Hunk #4 succeeded at 953 (offset 15 lines).
> > Hunk #5 succeeded at 993 (offset 1 line).
> > copying file alsa-kernel/core/pcm_native.c
> > patching file pcm_native.c
> > Hunk #4 succeeded at 1543 (offset -33 lines).
> > Hunk #6 succeeded at 2888 (offset 2 lines).
> > Hunk #7 FAILED at 2916.
> > Hunk #8 FAILED at 2932.
> > Hunk #9 succeeded at 2921 (offset -35 lines).
> > Hunk #10 succeeded at 3046 (offset 2 lines).
> > Hunk #11 succeeded at 3033 (offset -35 lines).
> > Hunk #12 succeeded at 3084 (offset 2 lines).
> > Hunk #13 succeeded at 3104 (offset -35 lines).
> > Hunk #14 succeeded at 3153 (offset 2 lines).
> > Hunk #15 succeeded at 3130 (offset -35 lines).
> > Hunk #16 succeeded at 3224 (offset 2 lines).
> > Hunk #17 succeeded at 3214 (offset -35 lines).
> > Hunk #18 succeeded at 3281 (offset 2 lines).
> > Hunk #19 succeeded at 3322 (offset -35 lines).
> > Hunk #20 succeeded at 3389 (offset 2 lines).
> > Hunk #21 succeeded at 3417 (offset -35 lines).
> > Hunk #22 succeeded at 3484 (offset 2 lines).
> > Hunk #23 succeeded at 3489 (offset -35 lines).
> > Hunk #24 succeeded at 3678 (offset 2 lines).
> > 2 out of 24 hunks FAILED -- saving rejects to file pcm_native.c.rej
> > make[2]: *** [pcm_native.c] Error 1
> =

> Check alsa-driver/HEAD file whether it contains the line
>    aa7a6f525401fd6cbd845a6de7ff92654f723785 Refresh pcm_natvie.patch
> =

> If not, grab alsa-driver-snapshot.tar.gz tarball again.
> =

> =

> Takashi


Hi Takashi,

the alsa-driver-snapshot still shows no update. So I downloaded the unstabl=
e version and I could find the line you mentioned there. Just tried compili=
ng again and, as you thought, the error changed:


patching file pcm_native.c
Hunk #3 succeeded at 368 (offset 1 line).
Hunk #5 succeeded at 2802 (offset 2 lines).
Hunk #7 succeeded at 2883 (offset 2 lines).
Hunk #9 succeeded at 2925 (offset 2 lines).
Hunk #11 succeeded at 3037 (offset 2 lines).
Hunk #13 succeeded at 3108 (offset 2 lines).
Hunk #15 succeeded at 3134 (offset 2 lines).
Hunk #17 succeeded at 3218 (offset 2 lines).
patch: **** malformed patch at line 382: @@ -3118,7 +3327,14 @@ static stru=
ct vm_operations_struct snd_p


I guess my patch program *is* a bit strict :)
Thanks,
Lorenzo
 		 	   		  =

_________________________________________________________________
More than messages=96check out the rest of the Windows Live=99.
http://www.microsoft.com/windows/windowslive/
