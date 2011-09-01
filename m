From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: [Mult]Re:  A debug version of the ALSA lib?
Date: Thu, 01 Sep 2011 16:19:42 +0200
Message-ID: <4E5F947E.7016.182F2A7@olivier.myriad-online.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>,
	<CACTFLAPNhWX6t00du=CtCMnR2adjsbMKK3v=HMmc8ivJMv7h8Q@mail.gmail.com>,
	<4E5F49CB.4010606@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 61AF3103835
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 17:20:06 +0200 (CEST)
In-reply-to: <4E5F49CB.4010606@ivitera.com>
Content-description: Mail message body
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you!

Unfortunately, it didn't work for me.
It started to install about 700 MB of miscellaneous packages, and failed on the 
making of the final package.
By precaustion I reverted to a previous snapshot of my system.
Isn't it a simpler way to get debug info?
Is it possible for instance to install libasound-dbg on Ubuntu 11.04?

Maybe my problem comes from run-time link with the library?
Does anyone use Code:Blocks to compile C applications that use ALSA?

If yes could you please tell  me the compiler/linker settings to properly use 
the ALSA shared libs? I added "/usr/lib/libasound.so.2" to the "Link library" 
section of the Linker settings, and it worked, but I still get crashes on the 
"snd_device_name_hints", especially within a small Mozilla plug-in in Firefox.

I can send the whole project, with a very easy test that shows the problem if 
needed.

Regards,
Olivier



Pavel Hofman <pavel.hofman@ivitera.com> wrote :
:

> >> To be able to go further, I'd need a debug version of the ALSA library,
> >> including variable names and source lines, which could let me find more
> >> easily what goes wrong and when.
> >>
> >> Is it possible to build such a library from the alsa-lib-1.0.24.1 sources? Or
> >> should I download and install another specific package?
> > 
> > The sources are the same. Whether you'll get a library with debug
> > symbols depends on the compile time options when building the lib. And
> > depending on your distribution, you might also be able to install the
> > debug-enabled version by choosing the -dbg package derivat.
> 
> 
> E.g. in debian/ubuntu I use dpkg-buildpackage with debug enabled, for
> details see e.g.
> http://jameswestby.net/tips/tips/compiling-debian-package-for-debug.html
> , just libasound2 instead of mutt.
