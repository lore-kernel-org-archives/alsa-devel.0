From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups
 for ASUS X542UN
Date: Wed, 5 Dec 2018 17:33:12 +0800
Message-ID: <CAPpJ_ed5qbhxUONdoACcQhH8jv1J_vvw4M-Vp4QwDsgQ1w8Vdw@mail.gmail.com>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com> <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Kailang Yang <kailang@realtek.com>
Cc: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Kailang <kailang@realtek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=885=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian-Hong,
>
> Could you test to change the model to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC=
?
>
> .chain_id =3D ALC256_FIXUP_ASUS_HEADSET_MODE  =3D=3D> change to ALC269_FI=
XUP_HEADSET_MODE_NO_HP_MIC

According to the comment
https://patchwork.kernel.org/patch/10713087/#22360253 , should I try
ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC on this model?

Jian-Hong Pan
