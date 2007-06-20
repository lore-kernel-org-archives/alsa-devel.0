From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Using aplay and arecord on an ARM
Date: Wed, 20 Jun 2007 10:40:51 -0500
Message-ID: <61c0054e0706200840k2b0f13c9q57581c380d39d2fc@mail.gmail.com>
References: <61c0054e0706191237n666fd422wcf13f874f108e64a@mail.gmail.com>
	<61c0054e0706191328y76f64570ne6a28108abafc2d5@mail.gmail.com>
	<75b66ecd0706191331y52ccc60dlc2634987c7309aba@mail.gmail.com>
	<s5hzm2vaqs7.wl%tiwai@suse.de>
	<8d6898730706200354vf5195e1u95c0484a89fe472a@mail.gmail.com>
	<61c0054e0706200727s1648cde3y578ae0c230ad1616@mail.gmail.com>
	<8d6898730706200732u60eed3b3l52a141d7e7a151c4@mail.gmail.com>
	<61c0054e0706200739k2b934a9avbffb133937adba4c@mail.gmail.com>
	<61c0054e0706200824v444d6c8dr6b6023b16043fa7@mail.gmail.com>
	<61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 4072C24334
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 17:40:53 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so369017uge
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 08:40:52 -0700 (PDT)
In-Reply-To: <61c0054e0706200827h389e2c6v46dfc544def95e82@mail.gmail.com>
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
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/20/07, Paul Kavan <pkavan@gmail.com> wrote:
>
> Okay:
>
> Here is where I ran into troubles yesterday. I am working on configuring
> alsa-utils. When I do:
>
> CC=arm-linux-gcc ./configure --target=arm-linux --with-versioned=no
> --prefix=/usr --host=i686-pc-linux-gnu
>
> I get the error:
>
> grhuser@pcL7:$ CC=arm-linux-gcc ./configure --target=arm-linux
> --with-versioned=no --prefix=/usr --host=i686-pc-linux-gnu
> configure: WARNING: If you wanted to set the --build type, don't use
> --host.
>     If a cross compiler is detected then cross compile mode will be used.
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for gawk... no
> checking for mawk... mawk
> checking whether make sets $(MAKE)... yes
> checking for i686-pc-linux-gnu-strip... no
> checking for strip... strip
> checking whether NLS is requested... yes
> checking for msgfmt... /usr/bin/msgfmt
> checking for gmsgfmt... /usr/bin/msgfmt
> checking for xgettext... /usr/bin/xgettext
> checking for msgmerge... /usr/bin/msgmerge
> checking for style of include used by make... GNU
> checking for i686-pc-linux-gnu-gcc... arm-linux-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... yes
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether arm-linux-gcc accepts -g... yes
> checking for arm-linux-gcc option to accept ISO C89... none needed
> checking dependency style of arm-linux-gcc... gcc3
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking for ld used by GCC...
> /home/grhuser/Linux_Builds/buildroot/build_arm/staging_dir/arm-linux-uclibc/bin/ld
> checking if the linker
> (/home/grhuser/Linux_Builds/buildroot/build_arm/staging_dir/arm-linux-uclibc/bin/ld)
> is GNU ld... yes
> checking for shared library run path origin... done
> checking for CFPreferencesCopyAppValue... no
> checking for CFLocaleCopyCurrent... no
> checking for GNU gettext in libc... no
> checking for iconv... no, consider installing GNU libiconv
> checking for GNU gettext in libintl... no
> checking whether to use NLS... no
> checking for i686-pc-linux-gnu-gcc... (cached) arm-linux-gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether arm-linux-gcc accepts -g... (cached) yes
> checking for arm-linux-gcc option to accept ISO C89... (cached) none
> needed
> checking dependency style of arm-linux-gcc... (cached) gcc3
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether ln -s works... yes
> checking for ALSA CFLAGS...
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
> checking for libasound headers version >= 1.0.12... not present.
> configure: error: Sufficiently new version of libasound not found.
>
> I know there has to be a flag or something here I need to set. Does anyone
> know what that might be?
>
> Paul
>

I think what occurs here is that the configure script is using my
cross-compilers and associated libs in

$HOME/Linux_Builds/buildroot/build_arm/staging_dir/

while the libs are actually given in

$HOME/Linux_Builds/buildroot/build_arm/root/usr/lib/

I am looking at the README and INSTALL and do not see a solution to this.

Does anyone have a solution to this?

Thanks.

Paul
