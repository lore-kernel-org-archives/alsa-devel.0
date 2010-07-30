From: loody <miloody@gmail.com>
Subject: some questions about sound system
Date: Sat, 31 Jul 2010 03:56:19 +0800
Message-ID: <AANLkTi=A27r6QhQGdK8=HhsPbTKphoGB6GNZ3M6MHbns@mail.gmail.com>
References: <AANLkTinPWzmmaP9OrHLKbZqCgGQuSGrpqUPtdW2Qi8ov@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CE561244A9
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 21:56:20 +0200 (CEST)
Received: by yxm8 with SMTP id 8so826426yxm.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 12:56:20 -0700 (PDT)
In-Reply-To: <AANLkTinPWzmmaP9OrHLKbZqCgGQuSGrpqUPtdW2Qi8ov@mail.gmail.com>
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

Dear all:
I just install Ubuntu9.10 on my laptop and I try to update my sound
system and recompile the utility.
there are some questions I met:
1. when configure the =A0utility
=A0 =A0it says

checking panel.h presence... no
checking for panel.h... no
configure: error: required curses helper header not found

and config.log is

"conftest.c:10:42: error: CoreFoundation/CFPreferences.h: No such file
or directory
conftest.c: In function 'main':
conftest.c:14: error: 'NULL' undeclared (first use in this function)
conftest.c:14: error: (Each undeclared identifier is repor"

the above error seems I miss install some package before.
I google the name but I have no improvement.

"conftest.c:20:28: error: ac_nonexistent.h: No such file or directory
configure:7397: $? =3D 1"

the above error seems the header located where the conftest.c doesn't expec=
t.

how could solve them all?

2. there are some configure file in share when I compile advance linux
sound architecture.
like alsa.conf.
have anyone know where I can find the naming rule?
appreciate your help,
miloody
