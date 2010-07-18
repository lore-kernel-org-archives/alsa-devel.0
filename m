From: John Simpson <john@swajime.com>
Subject: Re: Compiler errors in alsa-lib-1.0.22/test/*.c
Date: Sat, 17 Jul 2010 21:46:50 -0500
Message-ID: <AANLkTilDAsnNVSs17ochWuMfBlU_PIbL4OzH67CtPcLD@mail.gmail.com>
References: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>
	<4C3C0540.6020506@ladisch.de>
	<AANLkTinsZlWl0VtR8F1mHHYUNUd6jHvTjGhd_J2sdsoM@mail.gmail.com>
	<AANLkTinuYzw-4iuEyemaL4Jlh0NC0byhPBNJ5nu5tscX@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B5CD92453F
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jul 2010 04:46:52 +0200 (CEST)
Received: by iwn39 with SMTP id 39so3570827iwn.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 19:46:52 -0700 (PDT)
In-Reply-To: <AANLkTinuYzw-4iuEyemaL4Jlh0NC0byhPBNJ5nu5tscX@mail.gmail.com>
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

On Sat, Jul 17, 2010 at 9:28 PM, John Simpson <john@swajime.com> wrote:
> On Wed, Jul 14, 2010 at 1:56 AM, John Simpson <john@swajime.com> wrote:
>> The makefile did not do anything in the test directory for some reason.
>
> Now that I've had another chance to try this, the makefile still does
> not produce any executables:
>

ditto for Ubuntu Lucid:

john@system76-pc:~$ wget
ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.0.23.tar.bz2
john@system76-pc:~$ bunzip2 alsa-lib-1.0.23.tar.bz2
john@system76-pc:~$ tar -xf alsa-lib-1.0.23.tar
john@system76-pc:~$ cd alsa-lib-1.0.23/
john@system76-pc:~/alsa-lib-1.0.23$ ./configure
...
Creating asoundlib.h...
john@system76-pc:~/alsa-lib-1.0.23$ make
...
Making all in test
make[1]: Entering directory `/home/john/alsa-lib-1.0.23/test'
Making all in .
make[2]: Entering directory `/home/john/alsa-lib-1.0.23/test'
make[2]: Nothing to be done for `all-am'.
make[2]: Leaving directory `/home/john/alsa-lib-1.0.23/test'
Making all in lsb
make[2]: Entering directory `/home/john/alsa-lib-1.0.23/test/lsb'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/home/john/alsa-lib-1.0.23/test/lsb'
make[1]: Leaving directory `/home/john/alsa-lib-1.0.23/test'
...
john@system76-pc:~/alsa-lib-1.0.23$ sudo make install
[sudo] password for john:
...
Making install in test
make[1]: Entering directory `/home/john/alsa-lib-1.0.23/test'
Making install in .
make[2]: Entering directory `/home/john/alsa-lib-1.0.23/test'
make[3]: Entering directory `/home/john/alsa-lib-1.0.23/test'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory `/home/john/alsa-lib-1.0.23/test'
make[2]: Leaving directory `/home/john/alsa-lib-1.0.23/test'
...
john@system76-pc:~/alsa-lib-1.0.23$ ls test
client_event_filter.c  latency.c  Makefile     Makefile.in  midifile.c
 midiloop.c  oldapi.c  pcm_min.c    queue_timer.c  seq.c
seq-sender.c
control.c              lsb        Makefile.am  midifile.3   midifile.h
 namehint.c  pcm.c     playmidi1.c  rawmidi.c      seq-decoder.c
timer.c
john@system76-pc:~/alsa-lib-1.0.23$

No executable test files.  :-(
