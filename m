From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 18/31] HDA patch_via.c: Add 48K sample rate
	limit for S/PDIF streams.
Date: Thu, 8 Oct 2009 13:31:22 +0800
Message-ID: <16685ee0910072231v7982f1dbmf72da505aface54e@mail.gmail.com>
References: <002DCEC0FD024441A08A6AEFF6FFC6BB@DemianM1330>
	<20091006122144.GJ17195@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B57310392C
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:31:23 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5183722fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:31:22 -0700 (PDT)
In-Reply-To: <20091006122144.GJ17195@prithivi.gnumonks.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Welte <laforge@gnumonks.org>
Cc: tiwai@suse.de, Demian Martin <demianm_1@yahoo.com>, alsa-devel@alsa-project.org, lydiawang@viatech.com.cn, LoganLi@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 6, 2009 at 8:21 PM, Harald Welte <laforge@gnumonks.org> wrote:
> Hi all,
>
> I agree with the previous posts in this thread.
>
> The use of > 48kHz sample rate is common use today, so if the hardware su=
pports
> it, the driver should not disable it.
>
> Since there are some users that successfully use SPDIF with > 48kHz, it c=
annot
> be a general hardware problem. =A0If there's a general hardware problem, =
then
> it would never work for anyone.
>
> If there are some codec chips/variants/versions, or even certain boards t=
hat
> have bad SPDIf signal performance, then we should black-list those bad
> chips/versions/boards, rather than disable the feature for everyone.
>
> Also, as far as I understand, the worst thing that can happen when a "too=
 high"
> sample rate is used: =A0It will not work for some users on some hardware.=
 =A0That,
> I think, is acceptable (if no workaround / black-list can be created).
>
> This would be different if there are other effects: =A0If the high sample=
 rate
> would cause some hardware-lock-up or similar, then it definitely needs to=
 be
> disabled.
>
> Regards,
> --
> - Harald Welte <laforge@gnumonks.org> =A0 =A0 =A0 =A0 =A0 http://laforge.=
gnumonks.org/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0(ETSI EN 300 175-7 Ch. A6)
>

Hi, All
  According to the discussion, this patch is canceled, thank you for sugges=
tion.
