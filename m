From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] asoundrc,
 configure one virtual device for both input and output
Date: Sun, 01 Jul 2012 10:24:41 +0300
Message-ID: <1341127481.2919.30.camel@laptop>
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
	<1341125371.2919.27.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 52E7C247D2
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 09:24:44 +0200 (CEST)
In-Reply-To: <1341125371.2919.27.camel@laptop>
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

On Sun, 2012-07-01 at 09:49 +0300, Tanu Kaskinen wrote:
> I tried the "./gitcompile --enable-pulseaudio" command myself, and had
> this problem:
> 
> Making all in pulse
> make[2]: Entering directory `/home/tanu/dev/alsa-plugins/pulse'
> /bin/bash ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -MT ctl_pulse.lo -MD -MP -MF .deps/ctl_pulse.Tpo -c -o ctl_pulse.lo ctl_pulse.c
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -D_REENTRANT -I/usr/local/include -D_GNU_SOURCE -g -O2 -MT ctl_pulse.lo -MD -MP -MF .deps/ctl_pulse.Tpo -c ctl_pulse.c  -fPIC -DPIC -o .libs/ctl_pulse.o
> mv -f .deps/ctl_pulse.Tpo .deps/ctl_pulse.Plo
> /bin/bash ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -MT pulse.lo -MD -MP -MF .deps/pulse.Tpo -c -o pulse.lo pulse.c
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -D_REENTRANT -I/usr/local/include -D_GNU_SOURCE -g -O2 -MT pulse.lo -MD -MP -MF .deps/pulse.Tpo -c pulse.c  -fPIC -DPIC -o .libs/pulse.o
> mv -f .deps/pulse.Tpo .deps/pulse.Plo
> /bin/bash ../libtool --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa    -D_REENTRANT -I/usr/local/include   -D_GNU_SOURCE -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_ctl_pulse.la -rpath /usr/lib/alsa-lib ctl_pulse.lo pulse.lo -lasound    -L/usr/local/lib -lpulse   -lasound 
> libtool: link: gcc -shared  -fPIC -DPIC  .libs/ctl_pulse.o .libs/pulse.o   -L/usr/local/lib /usr/local/lib/libpulse.so -lasound  -O2   -pthread -Wl,-soname -Wl,libasound_module_ctl_pulse.so -o .libs/libasound_module_ctl_pulse.so
> /bin/sed: can't read /usr/lib/x86_64-linux-gnu/libsndfile.la: No such file or directory
> libtool: link: `/usr/lib/x86_64-linux-gnu/libsndfile.la' is not a valid libtool archive
> make[2]: *** [libasound_module_ctl_pulse.la] Error 1
> make[2]: Leaving directory `/home/tanu/dev/alsa-plugins/pulse'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/tanu/dev/alsa-plugins'
> make: *** [all] Error 2
> 
> Debian doesn't ship libsndfile.la, so I tried installing libsndfile from
> source. That didn't help at all. I eventually figured that since the
> alsa build system doesn't reference libsndfile at all, libpulse must
> somehow have a reference to /usr/lib/x86_64-linux-gnu/libsndfile.la
> (even though my system has never had that file installed). I rebuilt
> pulseaudio and installed it, and now it works (apparently because the
> rebuilt version references the version of libsndfile that was built from
> source, which includes libsndfile.la, instead of referencing the system
> version of libsndfile).
> 
> Does anyone know if the build system of alsa-plugins could be improved
> so that it doesn't use any external .la files when linking?

Update: now I'm unable to reproduce the problem, even after uninstalling
the self-compiled libsndfile instance and rebuilding pulseaudio again...
That means that I can't try any fixes, because there's nothing to fix.
Sorry for the noise.

-- 
Tanu
