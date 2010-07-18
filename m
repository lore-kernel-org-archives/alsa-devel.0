From: John Simpson <john@swajime.com>
Subject: Re: Compiler errors in alsa-lib-1.0.22/test/*.c
Date: Sat, 17 Jul 2010 21:45:34 -0500
Message-ID: <AANLkTinuYzw-4iuEyemaL4Jlh0NC0byhPBNJ5nu5tscX@mail.gmail.com>
References: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>
	<4C3C0540.6020506@ladisch.de>
	<AANLkTinsZlWl0VtR8F1mHHYUNUd6jHvTjGhd_J2sdsoM@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CA99B2453F
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jul 2010 04:45:36 +0200 (CEST)
Received: by iwn39 with SMTP id 39so3570252iwn.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 19:45:36 -0700 (PDT)
In-Reply-To: <AANLkTinsZlWl0VtR8F1mHHYUNUd6jHvTjGhd_J2sdsoM@mail.gmail.com>
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

On Wed, Jul 14, 2010 at 1:56 AM, John Simpson <john@swajime.com> wrote:
> The makefile did not do anything in the test directory for some reason.

Now that I've had another chance to try this, the makefile still does
not produce any executables:

[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23]ls
COPYING       MEMORY-LEAK   NOTES         aclocal.m4    compile
config.sub    depcomp       include       ltconfig      missing
test ChangeLog     Makefile.am   TODO          alsalisp
config.guess  configure     doc           install-sh    ltmain.sh
modules       utils INSTALL       Makefile.in   acinclude.m4  aserver
    config.log    configure.in  gitcompile    libtool       m4
   src           version
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23]./configure
...
config.status: executing depfiles commands
Creating asoundlib.h...
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23]ls
COPYING        Makefile       TODO           aserver
config.status  depcomp        install-sh     m4             test
ChangeLog      Makefile.am    acinclude.m4   compile        config.sub
   doc            libtool        missing        utils
INSTALL        Makefile.in    aclocal.m4     config.guess   configure
   gitcompile     ltconfig       modules        version
MEMORY-LEAK    NOTES          alsalisp       config.log
configure.in   include        ltmain.sh      src

[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23]root
[1|root@Nokia-N810-43-7|~]cd ~user/alsa-lib-1.0.23/
[1|root@Nokia-N810-43-7|/home/user/alsa-lib-1.0.23]make install
  === < clipped > ===
Making install in test
make[1]: Entering directory `/home/user/alsa-lib-1.0.23/test'
Making install in .
make[2]: Entering directory `/home/user/alsa-lib-1.0.23/test'
make[3]: Entering directory `/home/user/alsa-lib-1.0.23/test'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/home/user/alsa-lib-1.0.23/test'
make[2]: Leaving directory `/home/user/alsa-lib-1.0.23/test'
Making install in lsb
make[2]: Entering directory `/home/user/alsa-lib-1.0.23/test/lsb'
make[3]: Entering directory `/home/user/alsa-lib-1.0.23/test/lsb'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/home/user/alsa-lib-1.0.23/test/lsb'
make[2]: Leaving directory `/home/user/alsa-lib-1.0.23/test/lsb'
make[1]: Leaving directory `/home/user/alsa-lib-1.0.23/test'
  === < clipped > ===
[1|root@Nokia-N810-43-7|/home/user/alsa-lib-1.0.23]ls test
Makefile               control.c              midifile.c
oldapi.c               queue_timer.c          seq.c
Makefile.am            latency.c              midifile.h
pcm.c                  rawmidi.c              timer.c
Makefile.in            lsb                    midiloop.c
pcm_min.c              seq-decoder.c
client_event_filter.c  midifile.3             namehint.c
playmidi1.c            seq-sender.c
