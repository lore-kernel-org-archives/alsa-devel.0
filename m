From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [TINYCOMPRESS][v2 PATCH 1/7] Convert the build
	system to autotools
Date: Mon, 30 Mar 2015 17:02:33 +0100
Message-ID: <55197399.9070202@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
 <1427193154-6753-2-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C7F3260561
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 18:02:37 +0200 (CEST)
In-Reply-To: <1427193154-6753-2-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/24/2015 10:32 AM, Qais Yousef wrote:
> Hopefully this should make tinycompress a more robust package.
> This change splits the source into utils and lib.
> No functional changes was introduced.
>
> use autogen.sh to generate configure then run ./configure as with other
> packages.
> ---
> Changes from v2:
>   - Added Makefile.am to include directory to export tinycompress.h
>
>   AUTHORS                          |   0
>   COPYING                          |  51 ++++++
>   ChangeLog                        |   0
>   INSTALL                          | 365 +++++++++++++++++++++++++++++++++++++++
>   Makefile.am                      |   3 +
>   NEWS                             |   0
>   autogen.sh                       |   6 +
>   configure.ac                     |  32 ++++
>   include/Makefile.am              |   6 +
>   m4/.place_holder                 |   0
>   src/Makefile.am                  |   1 +
>   src/lib/Makefile.am              |   5 +
>   compress.c => src/lib/compress.c |   0
>   utils.c => src/lib/utils.c       |   0
>   src/utils/Makefile.am            |  11 ++
>   cplay.c => src/utils/cplay.c     |   0
>   crec.c => src/utils/crec.c       |   0
>   17 files changed, 480 insertions(+)
>   create mode 100644 AUTHORS
>   create mode 100644 COPYING
>   create mode 100644 ChangeLog
>   create mode 100644 INSTALL
>   create mode 100644 Makefile.am
>   create mode 100644 NEWS
>   create mode 100755 autogen.sh
>   create mode 100644 configure.ac
>   create mode 100644 include/Makefile.am
>   create mode 100644 m4/.place_holder
>   create mode 100644 src/Makefile.am
>   create mode 100644 src/lib/Makefile.am
>   rename compress.c => src/lib/compress.c (100%)
>   rename utils.c => src/lib/utils.c (100%)
>   create mode 100644 src/utils/Makefile.am
>   rename cplay.c => src/utils/cplay.c (100%)
>   rename crec.c => src/utils/crec.c (100%)
>
> diff --git a/AUTHORS b/AUTHORS
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/COPYING b/COPYING
> new file mode 100644
> index 000000000000..f9639260b2fd
> --- /dev/null
> +++ b/COPYING
> @@ -0,0 +1,51 @@
> +BSD LICENSE
> +
> +tinycompress library for compress audio offload in alsa
> +Copyright (c) 2011-2012, Intel Corporation
> +All rights reserved.
> +
> +Author: Vinod Koul <vinod.koul@linux.intel.com>
> +
> +Redistribution and use in source and binary forms, with or without
> +modification, are permitted provided that the following conditions are met:
> +
> +Redistributions of source code must retain the above copyright notice,
> +this list of conditions and the following disclaimer.
> +Redistributions in binary form must reproduce the above copyright notice,
> +this list of conditions and the following disclaimer in the documentation
> +and/or other materials provided with the distribution.
> +Neither the name of Intel Corporation nor the names of its contributors
> +may be used to endorse or promote products derived from this software
> +without specific prior written permission.
> +
> +THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> +AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> +IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> +ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> +LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> +CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> +SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> +INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> +CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> +ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
> +THE POSSIBILITY OF SUCH DAMAGE.
> +
> +LGPL LICENSE
> +
> +tinycompress library for compress audio offload in alsa
> +Copyright (c) 2011-2012, Intel Corporation.
> +
> +
> +This program is free software; you can redistribute it and/or modify it
> +under the terms and conditions of the GNU Lesser General Public License,
> +version 2.1, as published by the Free Software Foundation.
> +
> +This program is distributed in the hope it will be useful, but WITHOUT
> +ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> +FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
> +License for more details.
> +
> +You should have received a copy of the GNU Lesser General Public License
> +along with this program; if not, write to
> +the Free Software Foundation, Inc.,
> +51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
> diff --git a/ChangeLog b/ChangeLog
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/INSTALL b/INSTALL
> new file mode 100644
> index 000000000000..7d1c323beae7
> --- /dev/null
> +++ b/INSTALL
> @@ -0,0 +1,365 @@
> +Installation Instructions
> +*************************
> +
> +Copyright (C) 1994, 1995, 1996, 1999, 2000, 2001, 2002, 2004, 2005,
> +2006, 2007, 2008, 2009 Free Software Foundation, Inc.
> +
> +   Copying and distribution of this file, with or without modification,
> +are permitted in any medium without royalty provided the copyright
> +notice and this notice are preserved.  This file is offered as-is,
> +without warranty of any kind.
> +
> +Basic Installation
> +==================
> +
> +   Briefly, the shell commands `./configure; make; make install' should
> +configure, build, and install this package.  The following
> +more-detailed instructions are generic; see the `README' file for
> +instructions specific to this package.  Some packages provide this
> +`INSTALL' file but do not implement all of the features documented
> +below.  The lack of an optional feature in a given package is not
> +necessarily a bug.  More recommendations for GNU packages can be found
> +in *note Makefile Conventions: (standards)Makefile Conventions.
> +
> +   The `configure' shell script attempts to guess correct values for
> +various system-dependent variables used during compilation.  It uses
> +those values to create a `Makefile' in each directory of the package.
> +It may also create one or more `.h' files containing system-dependent
> +definitions.  Finally, it creates a shell script `config.status' that
> +you can run in the future to recreate the current configuration, and a
> +file `config.log' containing compiler output (useful mainly for
> +debugging `configure').
> +
> +   It can also use an optional file (typically called `config.cache'
> +and enabled with `--cache-file=config.cache' or simply `-C') that saves
> +the results of its tests to speed up reconfiguring.  Caching is
> +disabled by default to prevent problems with accidental use of stale
> +cache files.
> +
> +   If you need to do unusual things to compile the package, please try
> +to figure out how `configure' could check whether to do them, and mail
> +diffs or instructions to the address given in the `README' so they can
> +be considered for the next release.  If you are using the cache, and at
> +some point `config.cache' contains results you don't want to keep, you
> +may remove or edit it.
> +
> +   The file `configure.ac' (or `configure.in') is used to create
> +`configure' by a program called `autoconf'.  You need `configure.ac' if
> +you want to change it or regenerate `configure' using a newer version
> +of `autoconf'.
> +
> +   The simplest way to compile this package is:
> +
> +  1. `cd' to the directory containing the package's source code and type
> +     `./configure' to configure the package for your system.
> +
> +     Running `configure' might take a while.  While running, it prints
> +     some messages telling which features it is checking for.
> +
> +  2. Type `make' to compile the package.
> +
> +  3. Optionally, type `make check' to run any self-tests that come with
> +     the package, generally using the just-built uninstalled binaries.
> +
> +  4. Type `make install' to install the programs and any data files and
> +     documentation.  When installing into a prefix owned by root, it is
> +     recommended that the package be configured and built as a regular
> +     user, and only the `make install' phase executed with root
> +     privileges.
> +
> +  5. Optionally, type `make installcheck' to repeat any self-tests, but
> +     this time using the binaries in their final installed location.
> +     This target does not install anything.  Running this target as a
> +     regular user, particularly if the prior `make install' required
> +     root privileges, verifies that the installation completed
> +     correctly.
> +
> +  6. You can remove the program binaries and object files from the
> +     source code directory by typing `make clean'.  To also remove the
> +     files that `configure' created (so you can compile the package for
> +     a different kind of computer), type `make distclean'.  There is
> +     also a `make maintainer-clean' target, but that is intended mainly
> +     for the package's developers.  If you use it, you may have to get
> +     all sorts of other programs in order to regenerate files that came
> +     with the distribution.
> +
> +  7. Often, you can also type `make uninstall' to remove the installed
> +     files again.  In practice, not all packages have tested that
> +     uninstallation works correctly, even though it is required by the
> +     GNU Coding Standards.
> +
> +  8. Some packages, particularly those that use Automake, provide `make
> +     distcheck', which can by used by developers to test that all other
> +     targets like `make install' and `make uninstall' work correctly.
> +     This target is generally not run by end users.
> +
> +Compilers and Options
> +=====================
> +
> +   Some systems require unusual options for compilation or linking that
> +the `configure' script does not know about.  Run `./configure --help'
> +for details on some of the pertinent environment variables.
> +
> +   You can give `configure' initial values for configuration parameters
> +by setting variables in the command line or in the environment.  Here
> +is an example:
> +
> +     ./configure CC=c99 CFLAGS=-g LIBS=-lposix
> +
> +   *Note Defining Variables::, for more details.
> +
> +Compiling For Multiple Architectures
> +====================================
> +
> +   You can compile the package for more than one kind of computer at the
> +same time, by placing the object files for each architecture in their
> +own directory.  To do this, you can use GNU `make'.  `cd' to the
> +directory where you want the object files and executables to go and run
> +the `configure' script.  `configure' automatically checks for the
> +source code in the directory that `configure' is in and in `..'.  This
> +is known as a "VPATH" build.
> +
> +   With a non-GNU `make', it is safer to compile the package for one
> +architecture at a time in the source code directory.  After you have
> +installed the package for one architecture, use `make distclean' before
> +reconfiguring for another architecture.
> +
> +   On MacOS X 10.5 and later systems, you can create libraries and
> +executables that work on multiple system types--known as "fat" or
> +"universal" binaries--by specifying multiple `-arch' options to the
> +compiler but only a single `-arch' option to the preprocessor.  Like
> +this:
> +
> +     ./configure CC="gcc -arch i386 -arch x86_64 -arch ppc -arch ppc64" \
> +                 CXX="g++ -arch i386 -arch x86_64 -arch ppc -arch ppc64" \
> +                 CPP="gcc -E" CXXCPP="g++ -E"
> +
> +   This is not guaranteed to produce working output in all cases, you
> +may have to build one architecture at a time and combine the results
> +using the `lipo' tool if you have problems.
> +
> +Installation Names
> +==================
> +
> +   By default, `make install' installs the package's commands under
> +`/usr/local/bin', include files under `/usr/local/include', etc.  You
> +can specify an installation prefix other than `/usr/local' by giving
> +`configure' the option `--prefix=PREFIX', where PREFIX must be an
> +absolute file name.
> +
> +   You can specify separate installation prefixes for
> +architecture-specific files and architecture-independent files.  If you
> +pass the option `--exec-prefix=PREFIX' to `configure', the package uses
> +PREFIX as the prefix for installing programs and libraries.
> +Documentation and other data files still use the regular prefix.
> +
> +   In addition, if you use an unusual directory layout you can give
> +options like `--bindir=DIR' to specify different values for particular
> +kinds of files.  Run `configure --help' for a list of the directories
> +you can set and what kinds of files go in them.  In general, the
> +default for these options is expressed in terms of `${prefix}', so that
> +specifying just `--prefix' will affect all of the other directory
> +specifications that were not explicitly provided.
> +
> +   The most portable way to affect installation locations is to pass the
> +correct locations to `configure'; however, many packages provide one or
> +both of the following shortcuts of passing variable assignments to the
> +`make install' command line to change installation locations without
> +having to reconfigure or recompile.
> +
> +   The first method involves providing an override variable for each
> +affected directory.  For example, `make install
> +prefix=/alternate/directory' will choose an alternate location for all
> +directory configuration variables that were expressed in terms of
> +`${prefix}'.  Any directories that were specified during `configure',
> +but not in terms of `${prefix}', must each be overridden at install
> +time for the entire installation to be relocated.  The approach of
> +makefile variable overrides for each directory variable is required by
> +the GNU Coding Standards, and ideally causes no recompilation.
> +However, some platforms have known limitations with the semantics of
> +shared libraries that end up requiring recompilation when using this
> +method, particularly noticeable in packages that use GNU Libtool.
> +
> +   The second method involves providing the `DESTDIR' variable.  For
> +example, `make install DESTDIR=/alternate/directory' will prepend
> +`/alternate/directory' before all installation names.  The approach of
> +`DESTDIR' overrides is not required by the GNU Coding Standards, and
> +does not work on platforms that have drive letters.  On the other hand,
> +it does better at avoiding recompilation issues, and works well even
> +when some directory options were not specified in terms of `${prefix}'
> +at `configure' time.
> +
> +Optional Features
> +=================
> +
> +   If the package supports it, you can cause programs to be installed
> +with an extra prefix or suffix on their names by giving `configure' the
> +option `--program-prefix=PREFIX' or `--program-suffix=SUFFIX'.
> +
> +   Some packages pay attention to `--enable-FEATURE' options to
> +`configure', where FEATURE indicates an optional part of the package.
> +They may also pay attention to `--with-PACKAGE' options, where PACKAGE
> +is something like `gnu-as' or `x' (for the X Window System).  The
> +`README' should mention any `--enable-' and `--with-' options that the
> +package recognizes.
> +
> +   For packages that use the X Window System, `configure' can usually
> +find the X include and library files automatically, but if it doesn't,
> +you can use the `configure' options `--x-includes=DIR' and
> +`--x-libraries=DIR' to specify their locations.
> +
> +   Some packages offer the ability to configure how verbose the
> +execution of `make' will be.  For these packages, running `./configure
> +--enable-silent-rules' sets the default to minimal output, which can be
> +overridden with `make V=1'; while running `./configure
> +--disable-silent-rules' sets the default to verbose, which can be
> +overridden with `make V=0'.
> +
> +Particular systems
> +==================
> +
> +   On HP-UX, the default C compiler is not ANSI C compatible.  If GNU
> +CC is not installed, it is recommended to use the following options in
> +order to use an ANSI C compiler:
> +
> +     ./configure CC="cc -Ae -D_XOPEN_SOURCE=500"
> +
> +and if that doesn't work, install pre-built binaries of GCC for HP-UX.
> +
> +   On OSF/1 a.k.a. Tru64, some versions of the default C compiler cannot
> +parse its `<wchar.h>' header file.  The option `-nodtk' can be used as
> +a workaround.  If GNU CC is not installed, it is therefore recommended
> +to try
> +
> +     ./configure CC="cc"
> +
> +and if that doesn't work, try
> +
> +     ./configure CC="cc -nodtk"
> +
> +   On Solaris, don't put `/usr/ucb' early in your `PATH'.  This
> +directory contains several dysfunctional programs; working variants of
> +these programs are available in `/usr/bin'.  So, if you need `/usr/ucb'
> +in your `PATH', put it _after_ `/usr/bin'.
> +
> +   On Haiku, software installed for all users goes in `/boot/common',
> +not `/usr/local'.  It is recommended to use the following options:
> +
> +     ./configure --prefix=/boot/common
> +
> +Specifying the System Type
> +==========================
> +
> +   There may be some features `configure' cannot figure out
> +automatically, but needs to determine by the type of machine the package
> +will run on.  Usually, assuming the package is built to be run on the
> +_same_ architectures, `configure' can figure that out, but if it prints
> +a message saying it cannot guess the machine type, give it the
> +`--build=TYPE' option.  TYPE can either be a short name for the system
> +type, such as `sun4', or a canonical name which has the form:
> +
> +     CPU-COMPANY-SYSTEM
> +
> +where SYSTEM can have one of these forms:
> +
> +     OS
> +     KERNEL-OS
> +
> +   See the file `config.sub' for the possible values of each field.  If
> +`config.sub' isn't included in this package, then this package doesn't
> +need to know the machine type.
> +
> +   If you are _building_ compiler tools for cross-compiling, you should
> +use the option `--target=TYPE' to select the type of system they will
> +produce code for.
> +
> +   If you want to _use_ a cross compiler, that generates code for a
> +platform different from the build platform, you should specify the
> +"host" platform (i.e., that on which the generated programs will
> +eventually be run) with `--host=TYPE'.
> +
> +Sharing Defaults
> +================
> +
> +   If you want to set default values for `configure' scripts to share,
> +you can create a site shell script called `config.site' that gives
> +default values for variables like `CC', `cache_file', and `prefix'.
> +`configure' looks for `PREFIX/share/config.site' if it exists, then
> +`PREFIX/etc/config.site' if it exists.  Or, you can set the
> +`CONFIG_SITE' environment variable to the location of the site script.
> +A warning: not all `configure' scripts look for a site script.
> +
> +Defining Variables
> +==================
> +
> +   Variables not defined in a site shell script can be set in the
> +environment passed to `configure'.  However, some packages may run
> +configure again during the build, and the customized values of these
> +variables may be lost.  In order to avoid this problem, you should set
> +them in the `configure' command line, using `VAR=value'.  For example:
> +
> +     ./configure CC=/usr/local2/bin/gcc
> +
> +causes the specified `gcc' to be used as the C compiler (unless it is
> +overridden in the site shell script).
> +
> +Unfortunately, this technique does not work for `CONFIG_SHELL' due to
> +an Autoconf bug.  Until the bug is fixed you can use this workaround:
> +
> +     CONFIG_SHELL=/bin/bash /bin/bash ./configure CONFIG_SHELL=/bin/bash
> +
> +`configure' Invocation
> +======================
> +
> +   `configure' recognizes the following options to control how it
> +operates.
> +
> +`--help'
> +`-h'
> +     Print a summary of all of the options to `configure', and exit.
> +
> +`--help=short'
> +`--help=recursive'
> +     Print a summary of the options unique to this package's
> +     `configure', and exit.  The `short' variant lists options used
> +     only in the top level, while the `recursive' variant lists options
> +     also present in any nested packages.
> +
> +`--version'
> +`-V'
> +     Print the version of Autoconf used to generate the `configure'
> +     script, and exit.
> +
> +`--cache-file=FILE'
> +     Enable the cache: use and save the results of the tests in FILE,
> +     traditionally `config.cache'.  FILE defaults to `/dev/null' to
> +     disable caching.
> +
> +`--config-cache'
> +`-C'
> +     Alias for `--cache-file=config.cache'.
> +
> +`--quiet'
> +`--silent'
> +`-q'
> +     Do not print messages saying which checks are being made.  To
> +     suppress all normal output, redirect it to `/dev/null' (any error
> +     messages will still be shown).
> +
> +`--srcdir=DIR'
> +     Look for the package's source code in directory DIR.  Usually
> +     `configure' can determine that directory automatically.
> +
> +`--prefix=DIR'
> +     Use DIR as the installation prefix.  *note Installation Names::
> +     for more details, including other options available for fine-tuning
> +     the installation locations.
> +
> +`--no-create'
> +`-n'
> +     Run the configure checks, but stop before creating any output
> +     files.
> +
> +`configure' also accepts some other, not widely useful, options.  Run
> +`configure --help' for more details.
> +
> diff --git a/Makefile.am b/Makefile.am
> new file mode 100644
> index 000000000000..1c2beea94e73
> --- /dev/null
> +++ b/Makefile.am
> @@ -0,0 +1,3 @@
> +SUBDIRS = include src
> +
> +ACLOCAL_AMFLAGS = -I m4
> diff --git a/NEWS b/NEWS
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/autogen.sh b/autogen.sh
> new file mode 100755
> index 000000000000..87fd847c5092
> --- /dev/null
> +++ b/autogen.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +autoreconf --verbose --force --install || {
> +	echo 'autogen.sh failed';
> +	exit 1;
> +}
> diff --git a/configure.ac b/configure.ac
> new file mode 100644
> index 000000000000..9d2ce8183ecb
> --- /dev/null
> +++ b/configure.ac
> @@ -0,0 +1,32 @@
> +#                                               -*- Autoconf -*-
> +# Process this file with autoconf to produce a configure script.
> +
> +AC_PREREQ([2.63])
> +AC_INIT([tinycompress], [0.2.0])
> +AC_CONFIG_HEADERS([config.h])
> +AC_CONFIG_MACRO_DIR([m4])
> +
> +AM_INIT_AUTOMAKE(1.10)
> +LT_INIT(disable-static)
> +
> +# Checks for programs.
> +AC_PROG_CXX
> +AC_PROG_CC
> +AC_PROG_CPP
> +AC_PROG_INSTALL
> +AC_PROG_MAKE_SET
> +AM_PROG_CC_C_O
> +
> +# Checks for libraries.
> +
> +# Checks for typedefs, structures, and compiler characteristics.
> +
> +# Checks for library functions.
> +
> +AC_CONFIG_FILES([
> +Makefile
> +include/Makefile
> +src/Makefile
> +src/lib/Makefile
> +src/utils/Makefile])
> +AC_OUTPUT
> diff --git a/include/Makefile.am b/include/Makefile.am
> new file mode 100644
> index 000000000000..2a89e11b236f
> --- /dev/null
> +++ b/include/Makefile.am
> @@ -0,0 +1,6 @@
> +nobase_include_HEADERS = tinycompress/tinycompress.h
> +
> +noinst_HEADERS = sound/compress_offload.h \
> +		 sound/compress_params.h \
> +		 tinycompress/version.h \
> +		 tinycompress/tinymp3.h
> diff --git a/m4/.place_holder b/m4/.place_holder
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/src/Makefile.am b/src/Makefile.am
> new file mode 100644
> index 000000000000..be97404412eb
> --- /dev/null
> +++ b/src/Makefile.am
> @@ -0,0 +1 @@
> +SUBDIRS = lib utils
> diff --git a/src/lib/Makefile.am b/src/lib/Makefile.am
> new file mode 100644
> index 000000000000..01afb8a443a1
> --- /dev/null
> +++ b/src/lib/Makefile.am
> @@ -0,0 +1,5 @@
> +tinycompressdir = $(libdir)
> +
> +tinycompress_LTLIBRARIES = libtinycompress.la
> +libtinycompress_la_SOURCES = compress.c utils.c
> +libtinycompress_la_CFLAGS = -I $(top_builddir)/include
> diff --git a/compress.c b/src/lib/compress.c
> similarity index 100%
> rename from compress.c
> rename to src/lib/compress.c
> diff --git a/utils.c b/src/lib/utils.c
> similarity index 100%
> rename from utils.c
> rename to src/lib/utils.c
> diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
> new file mode 100644
> index 000000000000..0a3fc43c92cb
> --- /dev/null
> +++ b/src/utils/Makefile.am
> @@ -0,0 +1,11 @@
> +bin_PROGRAMS = cplay crecord
> +
> +cplay_SOURCES = cplay.c
> +crecord_SOURCES = cplay.c
> +

This should be crec.c :-/

Can you fix when you apply or do you want me to send v3?

> +cplay_CFLAGS = -I$(top_builddir)/include
> +crecord_CFLAGS = -I$(top_builddir)/include
> +
> +
> +cplay_LDADD = $(top_builddir)/src/lib/libtinycompress.la
> +crecord_LDADD = $(top_builddir)/src/lib/libtinycompress.la
> diff --git a/cplay.c b/src/utils/cplay.c
> similarity index 100%
> rename from cplay.c
> rename to src/utils/cplay.c
> diff --git a/crec.c b/src/utils/crec.c
> similarity index 100%
> rename from crec.c
> rename to src/utils/crec.c
