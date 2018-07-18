From: Srikanth Korangala Hari <srikanth.h@samsung.com>
Subject: RE: Re: [PATCH 1/1] Preventive fix in sound module
Date: Wed, 18 Jul 2018 16:28:20 +0530
Message-ID: <20180718105820epcms5p173879897edd4cc93b381f8125c11b91b@epcms5p1>
References: <s5hfu0gzw5e.wl-tiwai@suse.de>
        <1531908468-1352-1-git-send-email-srikanth.h@samsung.com>
        <CGME20180718100741epcas1p393bea852d102e903ab6a48ff952761db@epcms5p1>
Reply-To: srikanth.h@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfu0gzw5e.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "keescook@chromium.org" <keescook@chromium.org>, "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>, "perex@perex.cz" <perex@perex.cz>, "elfring@users.sourceforge.net" <elfring@users.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, CPGS <cpgs@samsung.com>
List-Id: alsa-devel@alsa-project.org


>>=C2=A0=0D=0A>>=C2=A0Signed-off-by:=C2=A0Srikanth=C2=A0K=C2=A0H=C2=A0<srik=
anth.h=40samsung.com>=0D=0A=C2=A0=0D=0A>What=C2=A0does=C2=A0this=C2=A0fix,=
=C2=A0and=C2=A0above=C2=A0all,=C2=A0why=C2=A0is=C2=A0this=C2=A0needed?=0D=
=0A=0D=0AHi,=0D=0A=0D=0AWhen=20the=20sound=20driver=20creates=20the=20timer=
=20without=20sound=20card=20object,=20then=20while=20reading=20the=20sound=
=20info=20entry=20the=20timer=20object=E2=80=99s=20card=20information=20is=
=20dereferenced=20without=20checking=20for=20NULL=20pointer=20which=20will=
=20result=20for=20kernel=20panic.=20I=20tried=20to=20simulate=20this=20scen=
ario=20and=20got=20below=20call=20stack,=0D=0A=5B=20=20=2036.668=5D=20E/DEV=
KMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Unable=20to=20handle=20kernel=
=20NULL=20pointer=20dereference=20at=20virtual=20address=2000000000=0D=0A=
=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20p=
gd=20=3D=20e52f0000=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=20=
0,=20T=20=20=20=200):=20=5B00000000=5D=20*pgd=3D00000000=0D=0A=5B=20=20=203=
6.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Internal=20err=
or:=20Oops:=205=20=5B=231=5D=20PREEMPT=20SMP=20ARM=0D=0A=5B=20=20=2036.668=
=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Modules=20linked=20=
in:=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=
=200):=20CPU:=201=20PID:=201258=20Comm:=20cat=20Tainted:=20G=20=20=20=20=20=
=20=20=20W=20=20=20=203.10.65-00121-g83e9b9b-dirty=20=2354-Tizen=0D=0A=5B=
=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20task=
:=20e653aec0=20ti:=20e52ec000=20task.ti:=20e52ec000=0D=0A=5B=20=20=2036.668=
=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20PC=20is=20at=20snd_=
timer_proc_read+0x104/0x278=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=
=20=20=200,=20T=20=20=20=200):=20LR=20is=20at=20snd_timer_proc_read+0xec/0x=
278=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=
=200):=20pc=20:=20=5B<c0527cfc>=5D=20=20=20=20lr=20:=20=5B<c0527ce4>=5D=20=
=20=20=20psr:=2060040013=5Cx0asp=20:=20e52eded0=20=20ip=20:=2000000000=20=
=20fp=20:=2010624dd3=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=
=200,=20T=20=20=20=200):=20r10:=20c08ded6c=20=20r9=20:=20e49e3bd8=20=20r8=
=20:=20c074f518=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=
=20T=20=20=20=200):=20r7=20:=20c0afbae4=20=20r6=20:=20eb95a000=20=20r5=20:=
=20e49e3240=20=20r4=20:=20eb257e00=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=
=20(P=20=20=20=200,=20T=20=20=20=200):=20r3=20:=2000000000=20=20r2=20:=2000=
000000=20=20r1=20:=20c0987cd7=20=20r0=20:=20e49e3240=0D=0A=5B=20=20=2036.66=
8=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=20=200):=20Flags:=20nZCv=20=
=20IRQs=20on=20=20FIQs=20on=20=20Mode=20SVC_32=20=20ISA=20ARM=20=20Segment=
=20user=0D=0A=5B=20=20=2036.668=5D=20E/DEVKMSG=20(P=20=20=20=200,=20T=20=20=
=20=200):=20Control:=2010c53c7d=20=20Table:=20a52f006a=20=20DAC:=2000000015=
=0D=0A=0D=0AHence=20this=20is=20a=20preventive=20patch=20to=20avoid=20kerne=
l=20panic=20in=20case=20if=20the=20card=20object=20passed=20to=20timer=20fu=
nction=20is=20NULL.=20This=20would=20not=20happen=20in=20normal=20case,=20b=
ut=20in=20case=20of=20buggy=20scenario=20this=20would=20results=20in=20kern=
el=20panic=20rather=20than=20graceful=20exit.=0D=0A=0D=0Athanks,=0D=0Asrika=
nth
