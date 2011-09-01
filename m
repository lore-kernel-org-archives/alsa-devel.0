From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Mult]Re: A debug version of the ALSA lib?
Date: Thu, 1 Sep 2011 17:46:04 +0200
Message-ID: <CACTFLANw7heRE2Gu3iPODTiB7JhA1Knz4+FVzokyS_fYhZJ_3w@mail.gmail.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	<CACTFLAPNhWX6t00du=CtCMnR2adjsbMKK3v=HMmc8ivJMv7h8Q@mail.gmail.com>
	<4E5F49CB.4010606@ivitera.com>
	<4E5F947E.7016.182F2A7@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FC9103835
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 17:46:08 +0200 (CEST)
Received: by pzk1 with SMTP id 1so3440065pzk.2
	for <alsa-devel@alsa-project.org>; Thu, 01 Sep 2011 08:46:04 -0700 (PDT)
In-Reply-To: <4E5F947E.7016.182F2A7@olivier.myriad-online.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olivier Guillion - Myriad <olivier@myriad-online.com>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 1, 2011 at 4:19 PM, Olivier Guillion - Myriad
<olivier@myriad-online.com> wrote:
> Unfortunately, it didn't work for me.
> It started to install about 700 MB of miscellaneous packages, and failed =
on the
> making of the final package.

How did you download them? And which distro are you using.

> By precaustion I reverted to a previous snapshot of my system.
> Isn't it a simpler way to get debug info?
> Is it possible for instance to install libasound-dbg on Ubuntu 11.04?

That should be possible, yes. Or just build the library yourself and
redirect your linker to take the self-compiled library rather than the
system-wide instance.

> Maybe my problem comes from run-time link with the library?
> Does anyone use Code:Blocks to compile C applications that use ALSA?
>
> If yes could you please tell =A0me the compiler/linker settings to proper=
ly use
> the ALSA shared libs? I added "/usr/lib/libasound.so.2" to the "Link libr=
ary"
> section of the Linker settings, and it worked, but I still get crashes on=
 the
> "snd_device_name_hints", especially within a small Mozilla plug-in in Fir=
efox.

I've never done such a thing myself, but maybe someone else has.

> I can send the whole project, with a very easy test that shows the proble=
m if
> needed.

People on this list are usually really busy and I'm not sure whether
anybody would offer such specifc support unless it points out a
specific problem in the ALSA code. But I can't speak for everyone
here, of course :)


Daniel
