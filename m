From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: questions for alsa-devel
Date: Wed, 02 Oct 2002 17:25:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2y99gdfsi.fsf@vador.mandrakesoft.com>
References: <200210021457.g92Evdsu029206@smtp.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210021457.g92Evdsu029206@smtp.mandrakesoft.com> (Paul
 Davis's message of "Wed, 02 Oct 2002 10:58:44 -0400")
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

> its just that my experience of using ALSA for several years when
> built with a kernel from kernel.org has been that i just type:
>
>      cd .../alsa-cvs/alsa-{driver,lib,utils}
> then
>      cvscompile
> or
>      ./configure && make && make install
>
> and it works. i was very suprised when this did not happen with my new
> mandrake system.

if it look for stuff in /usr/src/linux and if kernel-source is
installed, there might be serious problem since latest kernel that was
build from there may not (and surely is not) the up one you probably
use.
add this to the fact we used sybol versionning.
what's more the signature mechanism used by symbols versionning is not
such solid...

so the cleaner way is to recompile your own kernel from kernel source
after a make mrproper then build alsa modules.

this will :
- leave you with the std mdk kernel that worked previously and a new
  one with alsa 0.9

- make you use a good general principe even the odds than alsa prevent
  you to boot're quite low)

> > the problem will remains the same whatever you compiled the alsa
> > modules in the same time you compiled the kernel or as a separate
> > pacakge : applications linked with alsa-0.5 library won't be able
> > to dialog with alsa-0.9.0 kernel ...
>
> which applications are they? i know of very few ALSA apps that use
> 0.5, and to be honest, i think it would be much better for mandrake
> to not distribute them.

i cannot tell you which one exactely since as i'm dailly working on
cooker, i'have difficulties to tell you what changes occured between X
and Y days, but i know for sure there were quite some (sdl, mplayer
(well, was not exactely en example of the alsa api usage), wine, ...)
these were some of the bastards that ennoyed us when we switched to
alsa-0.9


> > > updating from 8.2 to 9.0 over a 56k link strikes me as a pretty
> > > absurd step to take.
> >
> > then, unless you absolutely need the fixes provided by the latest
> > alsa driver for your card, there's no point in upgrading it
> > without upgrading libalsa and relevant applications...
>
> the applications mean nothing to me, since i write audio apps for
> linux, and any existing ones that use 0.5 are not of much use to me
> for many different reasons.
>
> i know about the rest of ALSA. thierry, perhaps you don't know that
> i've been a significant contributor to ALSA for several years,
> including writing 3 lowlevel drivers, and participating in design
> discussions and general bitching sessions on alsa-devel for quite
> some time now.

different visions :

- an end user want coherent system with applications linked sound
  library that can use kernel drivers

- a developper may want latest drivers with multiples versions of the
  same lib even if in that case only one of these libraries can use
  alsa drivers

> > if you want less drivers and less features, that's your problem.
>
> no, i just wanted a system that would work. microtel shipped me a
> system with an audio chip not properly supported by ALSA 0.5. since
> i've been using ALSA for 3 or 4 years now, i naturally assumed that
> it would be simple to compile and install 0.9. it seems i was wrong
> about that.

if it's supported by newer alsa (don't understand why a hw vendor ship
such a sound card whereas only mdk9.0 integrated alsa-0.9.0), the
simple way (considering we've to build lots of kernel and considering
how kernel-source package is left (aka the need to type make
mrproper)), the cleaner way is to :
- recompile your own kernel, then newer alsa
- type make mrproper, copy /boot/config as .config; run make
  oldconfig; then recompile alsa should be enought

> ps. you probably know about the related problems with microtel
>     shipping systems with a video chipset not properly supported
>     by either the kernel framebuffer or X11. this isn't a purely
>     sound-related issue :)

not really, i'm a developper/packager in r&d, i'm mostly working on
cooker working on our package and developing our tools.
if i were some marketing or sales people, i would have. i develop and
package, i don't deeply look at sales contract, ...

developping mdk8.2 in late 2001 up to february 2002 (and don't forget
that we freeze quite some time before the final announce which is one
month at least before the boxes hit the shops) leave us with only
alsa-0.5.

the main goal was to have more drivers, not providing library we know
api would have been altered the next week.

then, our salesmen sell these boxes to shops, oem, ...

after that, if one vendor ship a distro which hw he has no driver for
is stupid (but as i don't know which configuration were shipped by
microtel, i don't know the exact problem), it's his problem.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
