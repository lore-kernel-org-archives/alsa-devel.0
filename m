From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 09:56:37 -0400
Message-ID: <4E088C15.3030608@digital-pipe.com>
References: <4E088113.6040500@digital-pipe.com>
	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 27BBE2437D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 15:58:29 +0200 (CEST)
Received: by gxk1 with SMTP id 1so2364790gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 06:58:24 -0700 (PDT)
In-Reply-To: <BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Pardini <pardo.bsso@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2011 09:35 AM, Adrian Pardini wrote:
> On 27/06/2011, David Henderson<dhenderson@digital-pipe.com>  wrote:
> [...]
>> checking for libasound headers version>= 1.0.16... not present.
>> configure: error: Sufficiently new version of libasound not
>> found.
>>
>>
>> Seeing as how this is a staging directory and not
>> the actual place the package is being installed to, I'm having the afore
>> mentioned problem because the alsa-utils package is looking under /...
>> for the header files instead of the /opt/staging/alsa/... directory.  Is
>> there a compile-time parameter that I can use so that alsa-utils looks
>> in the staging directory for the header files - just during the compile
>> phase?
> Hi Dave, try giving --with-alsa-inc-prefix=/opt/staging/alsa to the
> configure script.
>
>

Thanks for the help Adrian.  I tried passing that parameter to the 
configure script and here's the below output:

checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for gawk... no
checking for mawk... mawk
checking whether make sets $(MAKE)... yes
checking whether NLS is requested... yes
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for style of include used by make... GNU
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking build system type... i686-pc-linux-gnu
checking host system type... i686-pc-linux-gnu
checking for ld used by GCC... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for shared library run path origin... done
checking for CFPreferencesCopyAppValue... no
checking for CFLocaleCopyCurrent... no
checking for GNU gettext in libc... yes
checking whether to use NLS... yes
checking where the gettext function comes from... libc
checking for cross-compiler... gcc
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking for ALSA CFLAGS...  -I/opt/staging/alsa
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.16... not present.
configure: error: Sufficiently new version of libasound not found.

I've double checked that the header files are present:
$ ls -1 /opt/staging/alsa/var/share/include/alsa/
alisp.h
asoundef.h
asoundlib.h
conf.h
control_external.h
control.h
error.h
global.h
hwdep.h
iatomic.h
input.h
mixer_abst.h
mixer.h
output.h
pcm_external.h
pcm_extplug.h
pcm.h
pcm_ioplug.h
pcm_old.h
pcm_plugin.h
pcm_rate.h
rawmidi.h
seq_event.h
seq.h
seqmid.h
seq_midi_event.h
sound/
timer.h
version.h


Thoughts?  Thanks - Dave
