From: Jamey Kirby <kirby.jamey@gmail.com>
Subject: Re: Need some help building alsa-utils
Date: Wed, 25 Jul 2018 15:41:49 -0400
Message-ID: <CAJze_PvDAE7oqaK4MSR4e9UBYhRKkEO39wsLBEXyigpxAvry0w@mail.gmail.com>
References: <CAJze_PuEnezXojtMRmSf5yOtRja5XFKSiuT8q=mKKhWjdeLs4g@mail.gmail.com>
 <CAJze_Pvta=1wOe0bPir-ibBjViAGszY9mcjqGm6RJ+vZjS50Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 891F826774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:42:02 +0200 (CEST)
Received: by mail-lf1-f41.google.com with SMTP id u14-v6so6252750lfu.0
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 12:42:02 -0700 (PDT)
In-Reply-To: <CAJze_Pvta=1wOe0bPir-ibBjViAGszY9mcjqGm6RJ+vZjS50Sg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Issue resolved:

1) Old version from GitHub. Replaced with one from alsa org.
2) Ran ./gitcompile

All is well.


On Wed, Jul 25, 2018 at 2:47 PM Jamey Kirby <kirby.jamey@gmail.com> wrote:

> I have made progress. I am not at this point, and do not know what to do:
>
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> checking for a thread-safe mkdir -p... /bin/mkdir -p
> checking for gawk... gawk
> checking whether make sets $(MAKE)... yes
> checking whether make supports nested variables... yes
> checking for a sed that does not truncate output... /bin/sed
> checking whether NLS is requested... yes
> checking for msgfmt... /usr/bin/msgfmt
> checking for gmsgfmt... /usr/bin/msgfmt
> checking for xgettext... /usr/bin/xgettext
> checking for msgmerge... /usr/bin/msgmerge
> checking for style of include used by make... GNU
> checking for gcc... gcc
> checking whether the C compiler works... yes
> checking for C compiler default output file name... a.out
> checking for suffix of executables...
> checking whether we are cross compiling... no
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for gcc option to accept ISO C89... none needed
> checking whether gcc understands -c and -o together... yes
> checking dependency style of gcc... gcc3
> checking build system type... x86_64-pc-linux-gnu
> checking host system type... x86_64-pc-linux-gnu
> checking for ld used by gcc... /usr/bin/x86_64-linux-gnu-ld
> checking if the linker (/usr/bin/x86_64-linux-gnu-ld) is GNU ld... yes
> checking for shared library run path origin... /bin/bash: ./config.rpath:
> No such file or directory
> done
> checking how to run the C preprocessor... gcc -E
> checking for grep that handles long lines and -e... /bin/grep
> checking for egrep... /bin/grep -E
> checking for CFPreferencesCopyAppValue... no
> checking for CFLocaleCopyCurrent... no
> checking for GNU gettext in libc... yes
> checking whether to use NLS... yes
> checking where the gettext function comes from... libc
> checking for cross-compiler... gcc
> checking for gcc... (cached) gcc
> checking whether we are using the GNU C compiler... (cached) yes
> checking whether gcc accepts -g... (cached) yes
> checking for gcc option to accept ISO C89... (cached) none needed
> checking whether gcc understands -c and -o together... (cached) yes
> checking dependency style of gcc... (cached) gcc3
> checking whether ln -s works... yes
> checking for ALSA CFLAGS...
> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
> checking for libasound headers version >= 1.0.16... found.
> checking for snd_ctl_open in -lasound... yes
> checking for alsa/pcm.h... yes
> checking for alsa/mixer.h... yes
> checking for alsa/rawmidi.h... yes
> checking for alsa/seq.h... yes
> checking for librt... checking for clock_gettime in -lrt... yes
> checking for xmlto... yes
> checking for ANSI C header files... yes
> checking for ncursesw5-config... no
> checking for initscr in -lncursesw... no
> checking for ncurses5-config... yes
> checking for curses library... ncurses
> checking for curses header name... <ncurses.h>
> checking for curses compiler flags... -D_GNU_SOURCE -D_DEFAULT_SOURCE
> checking for curses NLS support... no
> checking for sys/types.h... yes
> checking for sys/stat.h... yes
> checking for stdlib.h... yes
> checking for string.h... yes
> checking for memory.h... yes
> checking for strings.h... yes
> checking for inttypes.h... yes
> checking for stdint.h... yes
> checking for unistd.h... yes
> checking panel.h usability... yes
> checking panel.h presence... yes
> checking for panel.h... yes
> checking menu.h usability... yes
> checking menu.h presence... yes
> checking for menu.h... yes
> checking form.h usability... yes
> checking form.h presence... yes
> checking for form.h... yes
> checking for new_panel in -lpanel... yes
> checking for new_menu in -lmenu... yes
> checking for new_form in -lform... yes
> checking for curses linker flags... -lform -lmenu -lpanel -lncurses -ltinfo
> checking for an ANSI C-conforming const... yes
> checking for inline... inline
> checking whether time.h and sys/time.h may both be included... yes
> checking whether gcc needs -traditional... no
> checking for special C compiler options needed for large files... no
> checking for _FILE_OFFSET_BITS value needed for large files... no
> checking that generated files are newer than configure... done
> configure: creating ./config.status
> config.status: error: cannot find input file: `Makefile.in'
>
> I'd like to get this built and tested. If it works out, i'd like to
> contribute my changes to alsa-utils to the repository.
>
>
> On Wed, Jul 25, 2018 at 12:31 AM Jamey Kirby <kirby.jamey@gmail.com>
> wrote:
>
>> I have been working with alsa for a while. We use it to archive
>> content from our radio station. I am using arecord.
>>
>> Build problem:
>>
>> 1) I cloned alsa-utils from github
>> 2) Spent two hours on Google trying to figure out how to build the darn
>> thing.
>> 3) I am running Ubuntu Server 18.0 with build-essentials installed.
>> 4) I get errors that I do not know how to fix when I try to setup
>> ./configure.
>> 5) I just need to make a build. What do I need to do?
>>
>> Feature:
>>
>> I am adding a feature. In the loop for capture(), when a new file is
>> opened, I want to close the old file (when doing continuous
>> recording). I added a new CLI parameter -K. When this is set, the
>> capture() loop will close the old file before opening the new file.
>>
>> This is an issue for me for two reasons:
>>
>> 1) When will i run out of file handles? I capture one hour files
>> continuously. After 10 hours, I see that all the capture files are
>> still open?
>> 2) I need to be notified when the file is closed so that I can do
>> post-processing of rht capture. I've tried inotifywait in a script,
>> and in another script I tried lsof. lsof works great, but the files
>> are open,. See, the main issue is that I need to know when each file
>> completes so that I can post process.
>>
>> Here is my post process script outline:
>>
>> #!/bin/bash
>>
>> for f in $HOME/vboxshare/jkirby/newarc/*.raw
>>   do
>>     filename=$(basename $f)
>>     open=$(lsof -t $f | wc -w)
>>     if [ $open -lt 1 ]
>>       then
>>         echo "$filename is closed"
>>         echo "Do post processing here"
>>       else
>>         echo "$filename is open by $open processe(s)"
>>     fi
>>   done
>>
>> If I could close the file before or after the previous file is closed,
>> I can do my work. Otherwise, I have no way to know if the file is open
>> and being processed or not.
>>
>> So, I've made the changes, I just need to build the darn thing.
>>
>> Thanks for any advice or help.
>>
>> --
>> Jamey Kirby
>> Disrupting the establishment since 1964
>>
>> This is a personal email account and as such, emails are not subject
>> to archiving. Nothing else really matters.
>>
>
>
> --
> Jamey Kirby
> Disrupting the establishment since 1964
>
> *This is a personal email account and as such, emails are not subject to
> archiving. Nothing else really matters.*
>


-- 
Jamey Kirby
Disrupting the establishment since 1964

*This is a personal email account and as such, emails are not subject to
archiving. Nothing else really matters.*
