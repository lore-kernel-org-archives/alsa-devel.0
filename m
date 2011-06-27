From: David Henderson <dhenderson@digital-pipe.com>
Subject: Re: compile problems
Date: Mon, 27 Jun 2011 12:30:40 -0400
Message-ID: <4E08B030.2030009@digital-pipe.com>
References: <4E088113.6040500@digital-pipe.com>	<BANLkTi=mDwbo59wT5tAhmV0K60f6+TT2BQ@mail.gmail.com>	<4E088C15.3030608@digital-pipe.com>	<s5h62nr2tdk.wl%tiwai@suse.de>	<4E08A246.7030300@digital-pipe.com>
	<s5hwrg71cmc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D77B624416
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jun 2011 18:32:25 +0200 (CEST)
Received: by gwj17 with SMTP id 17so2301290gwj.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2011 09:32:24 -0700 (PDT)
In-Reply-To: <s5hwrg71cmc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Pardini <pardo.bsso@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2011 12:07 PM, Takashi Iwai wrote:
> At Mon, 27 Jun 2011 11:31:18 -0400,
> David Henderson wrote:
>> On 06/27/2011 11:20 AM, Takashi Iwai wrote:
>>> At Mon, 27 Jun 2011 09:56:37 -0400,
>>> David Henderson wrote:
>>>> On 06/27/2011 09:35 AM, Adrian Pardini wrote:
>>>>> On 27/06/2011, David Henderson<dhenderson@digital-pipe.com>    wrote:
>>>>> [...]
>>>>>> checking for libasound headers version>= 1.0.16... not present.
>>>>>> configure: error: Sufficiently new version of libasound not
>>>>>> found.
>>>>>>
>>>>>>
>>>>>> Seeing as how this is a staging directory and not
>>>>>> the actual place the package is being installed to, I'm having the afore
>>>>>> mentioned problem because the alsa-utils package is looking under /...
>>>>>> for the header files instead of the /opt/staging/alsa/... directory.  Is
>>>>>> there a compile-time parameter that I can use so that alsa-utils looks
>>>>>> in the staging directory for the header files - just during the compile
>>>>>> phase?
>>>>> Hi Dave, try giving --with-alsa-inc-prefix=/opt/staging/alsa to the
>>>>> configure script.
>>>>>
>>>>>
>>>> Thanks for the help Adrian.  I tried passing that parameter to the
>>>> configure script and here's the below output:
>>>>
>>>> checking for a BSD-compatible install... /usr/bin/install -c
>>>> checking whether build environment is sane... yes
>>>> checking for gawk... no
>>>> checking for mawk... mawk
>>>> checking whether make sets $(MAKE)... yes
>>>> checking whether NLS is requested... yes
>>>> checking for msgfmt... /usr/bin/msgfmt
>>>> checking for gmsgfmt... /usr/bin/msgfmt
>>>> checking for xgettext... /usr/bin/xgettext
>>>> checking for msgmerge... /usr/bin/msgmerge
>>>> checking for style of include used by make... GNU
>>>> checking for gcc... gcc
>>>> checking for C compiler default output file name... a.out
>>>> checking whether the C compiler works... yes
>>>> checking whether we are cross compiling... no
>>>> checking for suffix of executables...
>>>> checking for suffix of object files... o
>>>> checking whether we are using the GNU C compiler... yes
>>>> checking whether gcc accepts -g... yes
>>>> checking for gcc option to accept ISO C89... none needed
>>>> checking dependency style of gcc... gcc3
>>>> checking build system type... i686-pc-linux-gnu
>>>> checking host system type... i686-pc-linux-gnu
>>>> checking for ld used by GCC... /usr/bin/ld
>>>> checking if the linker (/usr/bin/ld) is GNU ld... yes
>>>> checking for shared library run path origin... done
>>>> checking for CFPreferencesCopyAppValue... no
>>>> checking for CFLocaleCopyCurrent... no
>>>> checking for GNU gettext in libc... yes
>>>> checking whether to use NLS... yes
>>>> checking where the gettext function comes from... libc
>>>> checking for cross-compiler... gcc
>>>> checking for gcc... (cached) gcc
>>>> checking whether we are using the GNU C compiler... (cached) yes
>>>> checking whether gcc accepts -g... (cached) yes
>>>> checking for gcc option to accept ISO C89... (cached) none needed
>>>> checking dependency style of gcc... (cached) gcc3
>>>> checking for a BSD-compatible install... /usr/bin/install -c
>>>> checking whether ln -s works... yes
>>>> checking for ALSA CFLAGS...  -I/opt/staging/alsa
>>>> checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
>>>> checking for libasound headers version>= 1.0.16... not present.
>>>> configure: error: Sufficiently new version of libasound not found.
>>>>
>>>> I've double checked that the header files are present:
>>>> $ ls -1 /opt/staging/alsa/var/share/include/alsa/
>>> Pass the root path to alsa/*.h to --with-alsa-inc-prefix option, i.e.
>>> in your case, it's /opt/staging/alsa/var/share/include.
>>>
>>> But, the path is really odd and almost kidding (/share under
>>> /var...?)  Is it really correct?
>>>
>>>
>>> Takashi
>> Thanks for the additional help Takashi!  I've tried that as well without
>> any luck - still errors out at the same place and with the same
>> message.
> Then you should check config.log at the place error occurred.
> It contains more details.
> I guess you'll have to pass also --with-alsa-prefix pointing to the
> path where your local libasound.so.2 is placed.
>
>>   I know that some of the paths are non-traditional, but there
>> were certain guidelines that had to be met with this custom distro.  As
>> a result, some of the directories had to get moved.  That shouldn't be
>> adding to the problem right?  Since we're telling configure exactly
>> where to locate the files...
> Well, it's still very strange path.  The share sub-directory
> definitely doesn't belong under /var.  I'd understand that
> /opt/staging/alsa is a prefix for some build-root.  But /var/share
> is weird.  If any, it should be /usr/share.
>
>
> Takashi

I checked in the log file, but I didn't notice anything that gave an 
indication as to the failure.  Is there any spot in particular to look 
as the log just ends with "configure: exit 1", but everything above it 
just appears to be bash-styled variable assignments.

I ended up using the following configure parameters, but with the same 
results:
    --with-alsa-inc-prefix=/opt/staging/alsa/var/share/include/alsa 
--with-alsa-prefix=/opt/staging/alsa/lib
and I've confirmed that the appropriate files reside in the passed 
directories.

Obviously the traditional directory layout is /usr/share, but the distro 
doesn't have a /usr directory.  As a result, the directories that were 
under that parent directory had to be moved.  The chosen spot for some 
of them was /var (although the header files could have been moved to 
/lib/... perhaps).  At any rate, that's where the files are located.

Dave
