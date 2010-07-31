From: loody <miloody@gmail.com>
Subject: Re: some questions about sound system
Date: Sun, 1 Aug 2010 00:21:10 +0800
Message-ID: <AANLkTim+O7BmWopW1U_G0hQEwChJSy-On+RZiiVj=KhF@mail.gmail.com>
References: <AANLkTinPWzmmaP9OrHLKbZqCgGQuSGrpqUPtdW2Qi8ov@mail.gmail.com>
	<AANLkTi=A27r6QhQGdK8=HhsPbTKphoGB6GNZ3M6MHbns@mail.gmail.com>
	<AANLkTin_er-Ytg6hpF+jN3p6qoRnmEag==OjJLw_iD_J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A840124337
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Jul 2010 18:21:12 +0200 (CEST)
Received: by yxm8 with SMTP id 8so1007449yxm.38
	for <alsa-devel@alsa-project.org>; Sat, 31 Jul 2010 09:21:11 -0700 (PDT)
In-Reply-To: <AANLkTin_er-Ytg6hpF+jN3p6qoRnmEag==OjJLw_iD_J@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi:

2010/7/31 Daniel Chen <seven.steps@gmail.com>:
> On Fri, Jul 30, 2010 at 3:56 PM, loody <miloody@gmail.com> wrote:
>> 1. when configure the =A0utility
>> =A0 =A0it says
>>
>> checking panel.h presence... no
>> checking for panel.h... no
>> configure: error: required curses helper header not found
>
> $ sudo apt-get build-dep alsa-utils
I have tried the cmd you mention above.
But I still get the error message as :

checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking panel.h usability... yes
checking panel.h presence... yes
checking for panel.h... yes
checking menu.h usability... yes
checking menu.h presence... yes
checking for menu.h... yes
checking form.h usability... yes
checking form.h presence... yes
checking for form.h... yes
checking for new_panel in -lpanelw... no
configure: error: panelw library not found

Should I download the panelw library and compile it?
if so, where I can get it?
appreciate your help,
miloody
>
>> 2. there are some configure file in share when I compile advance linux
>> sound architecture.
>> like alsa.conf.
>> have anyone know where I can find the naming rule?
>
> These correspond to the card names.
>
> -Dan
>
