From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] asoundrc,
 configure one virtual device for both input and output
Date: Sun, 01 Jul 2012 09:49:31 +0300
Message-ID: <1341125371.2919.27.camel@laptop>
References: <CAHwRF1qfpYmCssGqFjdeEPxySEuvT+np-Jk5Dsbnq85L+c79sQ@mail.gmail.com>
	<CAHwRF1pb=w6T=d1G-6uw7x-Whzy=EWMmmSoTQjiT1HfJFgFEmg@mail.gmail.com>
	<1340977549.2928.16.camel@laptop>
	<CAHwRF1rY-u1iSEpph8ZhTaJ6WVOtXy8HYNEqnfWs82_P6egg=Q@mail.gmail.com>
	<1340983653.2928.25.camel@laptop>
	<CAHwRF1rgc0LN6U1AOa9=7=MOWq9xMRCdFWdoDcENWsyhfyk0QA@mail.gmail.com>
	<1340992674.2928.117.camel@laptop>
	<CAHwRF1rKvMc6zbZWGnGhTYKaTP-gzTD+ZzpDLOzBRdjWCh170g@mail.gmail.com>
	<1341042460.29402.5.camel@laptop>
	<CAHwRF1ruQZ=BeD9qPNF-BC+NjXQAaiLugbPVCQ1PT+Sibjo4+Q@mail.gmail.com>
	<1341045526.29402.19.camel@laptop>
	<CAHwRF1rNHiAHSDhMAZ9H94n16SBkJSiK5tqEdXZRTJbXvfCFNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C3A17247B8
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 08:49:35 +0200 (CEST)
In-Reply-To: <CAHwRF1rNHiAHSDhMAZ9H94n16SBkJSiK5tqEdXZRTJbXvfCFNg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Amar Akshat <amar.akshat@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

(CC'ing alsa-devel, because I had problems with building alsa-plugins)

On Sun, 2012-07-01 at 14:16 +0900, Amar Akshat wrote:
> Help me here with two things,
> 
> 1) How do I fix this and test, as in should I clone the alsa-project,
> or download alsa code and fix and compile ? In case I have to clone
> it, can you also provide me the clone instructions.

git clone git://git.alsa-project.org/alsa-plugins.git alsa-plugins
cd alsa-plugins
./gitcompile --enable-pulseaudio

If the configure script complains about missing dependencies, you'll
need to install them.

After you have made your changes, I believe you should be able to test
them by running "make && sudo make install". I haven't tried that
myself.

I tried the "./gitcompile --enable-pulseaudio" command myself, and had
this problem:

Making all in pulse
make[2]: Entering directory `/home/tanu/dev/alsa-plugins/pulse'
/bin/bash ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -MT ctl_pulse.lo -MD -MP -MF .deps/ctl_pulse.Tpo -c -o ctl_pulse.lo ctl_pulse.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -D_REENTRANT -I/usr/local/include -D_GNU_SOURCE -g -O2 -MT ctl_pulse.lo -MD -MP -MF .deps/ctl_pulse.Tpo -c ctl_pulse.c  -fPIC -DPIC -o .libs/ctl_pulse.o
mv -f .deps/ctl_pulse.Tpo .deps/ctl_pulse.Plo
/bin/bash ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -MT pulse.lo -MD -MP -MF .deps/pulse.Tpo -c -o pulse.lo pulse.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -D_REENTRANT -I/usr/local/include -D_GNU_SOURCE -g -O2 -MT pulse.lo -MD -MP -MF .deps/pulse.Tpo -c pulse.c  -fPIC -DPIC -o .libs/pulse.o
mv -f .deps/pulse.Tpo .deps/pulse.Plo
/bin/bash ../libtool --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_ctl_pulse.la -rpath /usr/lib/alsa-lib ctl_pulse.lo pulse.lo -lasound    -L/usr/local/lib -lpulse   -lasound 
libtool: link: gcc -shared  -fPIC -DPIC  .libs/ctl_pulse.o .libs/pulse.o   -L/usr/local/lib /usr/local/lib/libpulse.so -lasound  -O2   -pthread -Wl,-soname -Wl,libasound_module_ctl_pulse.so -o .libs/libasound_module_ctl_pulse.so
/bin/sed: can't read /usr/lib/x86_64-linux-gnu/libsndfile.la: No such file or directory
libtool: link: `/usr/lib/x86_64-linux-gnu/libsndfile.la' is not a valid libtool archive
make[2]: *** [libasound_module_ctl_pulse.la] Error 1
make[2]: Leaving directory `/home/tanu/dev/alsa-plugins/pulse'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/tanu/dev/alsa-plugins'
make: *** [all] Error 2

Debian doesn't ship libsndfile.la, so I tried installing libsndfile from
source. That didn't help at all. I eventually figured that since the
alsa build system doesn't reference libsndfile at all, libpulse must
somehow have a reference to /usr/lib/x86_64-linux-gnu/libsndfile.la
(even though my system has never had that file installed). I rebuilt
pulseaudio and installed it, and now it works (apparently because the
rebuilt version references the version of libsndfile that was built from
source, which includes libsndfile.la, instead of referencing the system
version of libsndfile).

Does anyone know if the build system of alsa-plugins could be improved
so that it doesn't use any external .la files when linking?

> 2) and after my modifications, my config in asoundrc should look like this ?
> 
> pcm.pulse_dev1 {
>   type pulse
>   source alsa_input.pci-0000_00_1b.0.analog-stereo
>   sink alsa_output.pci-0000_00_1b.0.analog-mono
> }

Yes.

-- 
Tanu
