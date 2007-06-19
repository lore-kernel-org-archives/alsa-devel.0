From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Writing an AT91SAM9260-EK Dumb Codec Driver
Date: Tue, 19 Jun 2007 09:41:05 -0500
Message-ID: <61c0054e0706190741q56f3ae77of24a227c11f180bb@mail.gmail.com>
References: <61c0054e0706151146i26514503hb0bfc99ad8399791@mail.gmail.com>
	<1181934519.26658.94.camel@localhost.localdomain>
	<61c0054e0706151406o2cc8b4c2x502e7fdb38a39a3e@mail.gmail.com>
	<61c0054e0706180851y49fc8c1cs7a27c4f84d10904f@mail.gmail.com>
	<61c0054e0706181007g6d7b9de0te1c27ffefebc2225@mail.gmail.com>
	<1182186958.26658.118.camel@localhost.localdomain>
	<1182187444.26658.121.camel@localhost.localdomain>
	<61c0054e0706181037i67e64668h2528cf756f963067@mail.gmail.com>
	<61c0054e0706181230o3e7f68b0u4ebd7e02f70e96e8@mail.gmail.com>
	<1182245470.26658.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A2AC243E8
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 16:41:06 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so2125577mue
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 07:41:05 -0700 (PDT)
In-Reply-To: <1182245470.26658.128.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/19/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
>
> On Mon, 2007-06-18 at 14:30 -0500, Paul Kavan wrote:
>
> >
> > Am I at a point now where I can try to get alsa-lib and alsa-util in
> > place? If so, what version? I found some tars at:
> >
> > http://www.alsa-project.org/alsa/ftp/lib/
> >
> > Is that the best place to get them? I am using buildroot, but not sure
> > if ALSA stuff is ready for primetime there. I guess I should check on
> > this asap.
> >
>
> Afaik, there is an issue with buildroot atm (please someone correct me
> if it's now fixed) when it comes to building alsa-lib for ARM. (please
> search archives for details).


No, I think you are right. I have tried a few recommended patches, but they
do not work.

Fwiw, I use openembedded for all my embedded builds without any problems
> atm. http://www.openembedded.org


At some point when I have some time, I am going to give it a try. I have
managed to build the libs and have those in my rfs using:

 CC=arm-linux-gcc ./configure --host=arm-linux
--prefix=$HOME/buildroot/build_arm/root/usr --with-versioned=no

...and then...

make install

With this, I get the /usr/ entries in my rfs. However, I have had troubles
building alsa-utils. When I try:

CC=arm-linux-gcc ./configure --host=arm-linux
--prefix=$HOME/buildroot/build_arm/root/usr --with-versioned=no

I get:

grhuser@pcL7:$ CC=arm-linux-gcc ./configure --host=arm-linux
--prefix=$HOME/buildroot/build_arm/root/usr --with-versioned=no
configure: WARNING: If you wanted to set the --build type, don't use --host.
    If a cross compiler is detected then cross compile mode will be used.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking for arm-linux-strip... arm-linux-strip
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for arm-linux-gcc... arm-linux-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... yes
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether arm-linux-gcc accepts -g... yes
checking for arm-linux-gcc option to accept ISO C89... none needed
checking dependency style of arm-linux-gcc... gcc3
checking build system type... i686-pc-linux-gnu
checking host system type... arm-unknown-linux-gnu
checking for ld used by GCC...
/home/grhuser/buildroot/build_arm/staging_dir/arm-linux-uclibc/bin/ld
checking if the linker
(/home/grhuser/buildroot/build_arm/staging_dir/arm-linux-uclibc/bin/ld) is
GNU ld... yes
checking for shared library run path origin... done
checking for CFPreferencesCopyAppValue... no
checking for CFLocaleCopyCurrent... no
checking for GNU gettext in libc... no
checking for iconv... no, consider installing GNU libiconv
checking for GNU gettext in libintl... no
checking whether to use NLS... no
checking for arm-linux-gcc... (cached) arm-linux-gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether arm-linux-gcc accepts -g... (cached) yes
checking for arm-linux-gcc option to accept ISO C89... (cached) none needed
checking dependency style of arm-linux-gcc... (cached) gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.12... not present.
configure: error: Sufficiently new version of libasound not found.


Not sure what is the problem here. I have

file:///home/grhuser/buildroot/build_arm/root/usr/lib/libasound.so.2.0.0

in my rfs. Any suggestions?

Paul

Liam
>
>


-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
