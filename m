From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: questions for alsa-devel
Date: Wed, 02 Oct 2002 16:07:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m27kh1djdd.fsf@vador.mandrakesoft.com>
References: <200210021357.g92DvYsu010195@smtp.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210021357.g92DvYsu010195@smtp.mandrakesoft.com> (Paul
 Davis's message of "Wed, 02 Oct 2002 09:58:34 -0400")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis <pbd@op.net> writes:

> > hum, mdk9.0 is compiled with module versionning and we've no
> > problems (i mean there're bugs but not such problems)
>
> this is 8.2 ...

this means that we compile rc3 with versionning symbols without
problems, so this answer takashi fear

> i have a bit of a problem with all of this. why doesn't ALSA build
> "out of the box"? the description you've given of what is necessary
> to get this to work seems (for the most part) to be a bit
> ridiculous.

insulting people that take time to answer you has always been a
constructive & efficient communication way.

> > 4) note that if you boot with a kernel with alsa-0.9.0, all your
> >    alsa apps won't work unless you use them in oss emulation mode.
>
> why is this? note that i never compile ALSA as part of the kernel,
> and i doubt that i ever will, even when 2.5/2.6/3.0 comes out. i
> prefer to be able to update my drivers without touching my kernel
> source.

the problem will remains the same whatever you compiled the alsa
modules in the same time you compiled the kernel or as a separate
pacakge : applications linked with alsa-0.5 library won't be able to
dialog with alsa-0.9.0 kernel ...

> updating from 8.2 to 9.0 over a 56k link strikes me as a pretty
> absurd step to take.

then, unless you absolutely need the fixes provided by the latest alsa
driver for your card, there's no point in upgrading it without
upgrading libalsa and relevant applications...

> having to specifically install kernel source to compile ALSA (and
> presumably other drivers) seems very odd to me. i would understand
> if ALSA just failed to compile without that step, but i didn't ask
> for or say no to a kernel source package, and ALSA compiled just
> fine.

alsa can compile fine as an extra package providing you've kernel
headers and the right links in /boot and /lib/modules (config, build,
System.map, ...)

> frankly, i was very suprised to get ALSA 0.5 in mdk8.2. its been
> publically stated for months and months that 0.5 is no longer under
> development and is not really supported (though takashi has done a
> great job with it). i did a quick search with rpmdrake to see if a
> 0.9.0 rpm was on the installation disks, but i couldn't find it.

mdk8.2 is more than 6 monthes old; i don't have yet time support in
tcp/ip to download future version of alsa-0.9.0 when only stable
versions of alsa-0.5.x were out...

the point of alsa-0.5.x integration in mandrake kernel was more
drivers (there're lots of cards not supported by oss drivers but by
alsa. eg the fm801 i used to have)

we also put the corresponding alsa libs and tools since they enable
some more features in some apps.

if you want less drivers and less features, that's your problem.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
