From: John Simpson <john@swajime.com>
Subject: Re: "Playback open error: Inappropriate ioctl for
	device" in alsa-lib-1.0.22/test/*.c
Date: Mon, 26 Jul 2010 07:50:37 -0500
Message-ID: <AANLkTikYRpsipT4hqAav6Wy8HeY6x_BnZGqfbgBQ_fsp@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 26EFB246F6
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 14:50:39 +0200 (CEST)
Received: by iwn39 with SMTP id 39so3089145iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 05:50:39 -0700 (PDT)
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

On 7/21/10, John Simpson <john@swajime.com> wrote:
> On 7/21/10, Clemens Ladisch <clemens@ladisch.de> wrote:
>> John Simpson wrote:
>>> Playback open error: Inappropriate ioctl for device
>>
>> Make sure that both your kernel and your alsa-lib use the correct
>> compiler and compiler flags (where "correct" usually means "whatever
>> the vendor's distribution uses").
>
> You've gone way over my head ...
> How do I find out what flags were used to compile the kernel?
>
>>
>>> This time, checking out https://vcs.maemo.org/svn/dsp-alsa
>>
>> It would be nice to know what the changes from the original alsa-lib
>> are; in theory, they should go upstream.
>
> I agree ... but it looks like that is an abandoned project; at
> https://garage.maemo.org/plugins/scmsvn/viewcvs.php/?root=dsp-alsa it
> says the last modification was 3 years ago.  The text file "version"
> says 1.0.10
>
> I found that "apt-get source libasound2" gives me a newer version:
> [1|user at Nokia-N810-43-7|~/src/alsa-lib-1.0.14sa/test]cat
> ../../alsa-lib_1.0.14sa-2maemo2.dsc
> Format: 1.0
> Source: alsa-lib
> Version: 1.0.14sa-2maemo2
> Binary: lib32asound2-dev, lib64asound2, lib32asound2, libasound2-dev,
> libasound2, libasound2-doc, libasound2-dbg, lib64asound2-dev
> Maintainer: Debian ALSA Maintainers <pkg-alsa-devel at
> lists.alioth.debian.org>
> Architecture: any
> Standards-Version: 3.7.2
> Build-Depends: debhelper (>= 4.2.32), quilt (>= 0.40), autotools-dev,
> doxygen, libc6-dev-powerpc [ppc64], libc6-dev-i386 [amd64],
> libc6-dev-ppc64 [powerpc], libc6-dev-s390x [s390], libc6-dev-sparc64
> [sparc], lib32gcc1 [amd64 ppc64], libc6-dev (>= 2.5) [armel]
> Vcs-Browser: http://svn.debian.org/wsvn/pkg-alsa/trunk/alsa-lib/
> Uploaders: Jordi Mallach <jordi at debian.org>, Mikael Magnusson
> <mikma at users.sourceforge.net>, Elimar Riesebieter <riesebie at
> lxtec.de>,
> Marc-Andre Lureau <marc-andre.lureau at nokia.com>
> Vcs-Svn: svn://svn.debian.org/pkg-alsa/trunk/alsa-lib
> Files:
>  5542a18a1479e4de4b9890e30e94588e 1099165 alsa-lib_1.0.14sa.orig.tar.gz
>  fc02aa3dbf2f66fb090e02ada703cc1d 47455 alsa-lib_1.0.14sa-2maemo2.diff.gz
>
> This version seems to install correctly, but still gives me no sound.
> The full log of my latest effort is here ->
> http://www.swajime.com/n810/alsa-lib_1.0.14sa-2maemo2.log
>>
>>> $ cd dsp-alsa/trunk/alsa-lib
>>> #### cvscompile does not succeed
>>
>> Why?
>
> I honestly don't know.  :-(  It looks like a bug in m4?  Here is the
> log for cvscompile:
> [1|root@Nokia-N810-43-7|/home/user/src/dsp-alsa/trunk/alsa-lib]cat
> cvscompile
> #!/bin/bash
>
> touch ltconfig
> libtoolize --force --copy --automake
> aclocal $ACLOCAL_FLAGS
> autoheader
> automake --foreign --copy --add-missing
> touch depcomp		# seems to be missing for old automake
> autoconf
> export CFLAGS='-O2 -Wall -W -pipe -g'
> echo "CFLAGS=$CFLAGS"
> echo "./configure $@"
> ./configure $@ || exit 1
> unset CFLAGS
> if [ -z "$CVSCOMPILE_NO_MAKE" ]; then
>   make
> fi
> [1|user@Nokia-N810-43-7|~/src/dsp-alsa/trunk/alsa-lib]bash -v ./cvscompile
> #!/bin/bash
>
> touch ltconfig
> libtoolize --force --copy --automake
> aclocal $ACLOCAL_FLAGS
> aclocal: configure.in: 41: macro `AM_PROG_LIBTOOL' not found in library
> autoheader
> configure.in:41: /usr/local/bin/m4: ERROR: Copying inserted file: No
> space left on device
> autom4te: /usr/local/bin/m4 failed with exit status: 1
> autoheader: /usr/local/bin/autom4te failed with exit status: 1
> automake --foreign --copy --add-missing
> configure.in:41: /usr/local/bin/m4: ERROR: Copying inserted file: No
> space left on device
> autom4te: /usr/local/bin/m4 failed with exit status: 1
> configure.in: no proper invocation of AM_INIT_AUTOMAKE was found.
> configure.in: You should verify that configure.in invokes AM_INIT_AUTOMAKE,
> configure.in: that aclocal.m4 is present in the top-level directory,
> configure.in: and that aclocal.m4 was recently regenerated (using aclocal).
> automake: no `Makefile.am' found or specified
> touch depcomp		# seems to be missing for old automake
> autoconf
> configure.in:41: /usr/local/bin/m4: ERROR: Copying inserted file: No
> space left on device
> autom4te: /usr/local/bin/m4 failed with exit status: 1
> export CFLAGS='-O2 -Wall -W -pipe -g'
> echo "CFLAGS=$CFLAGS"
> CFLAGS=-O2 -Wall -W -pipe -g
> echo "./configure $@"
> ./configure
> ./configure $@ || exit 1
> ./cvscompile: line 13: ./configure: No such file or directory
> [1|user@Nokia-N810-43-7|~/src/dsp-alsa/trunk/alsa-lib]
>
>>
>>> $ .libs/pcm -D 'default' -vf 440
>>> Playback device is default
>>> Stream parameters are 44100Hz, S16_LE, 1 channels
>>> Sine wave rate is 440.0000Hz
>>> Using transfer method: write
>>>
>>> Still no sound :-(
>>
>> Mixer controls not set?  (amixer and alsamixer are in alsa-utils)
>
> I haven't been able to find alsa-utils in any maemo/diablo repositories.

I found that alsa-tools is in the fremantle repo:
http://repository.maemo.org/pool/fremantle/free/a/alsa-utils/

It bricks the n810 :-(

Fremantle is not compatible with the n810 as I remember.
