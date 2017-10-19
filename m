From: Nutchanon Wetchasit <Nutchanon.Wetchasit@gmail.com>
Subject: Re: [BUG] aplay doesn't honor `-t raw` when WAVE
 header is detected on input
Date: Thu, 19 Oct 2017 13:36:41 +0700
Message-ID: <CAB5A+AtrFcorr-yDgmC=weQBr5rLV=DFEWSG0JkSdyuLZP5Xkg@mail.gmail.com>
References: <CAB5A+AtCtRbNiKh4XtFOU1KtC4uBc=5RRTwvJ6UNKHD8oxVeBA@mail.gmail.com>
 <s5hinff1fd9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com
 [209.85.213.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D409266DD4
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 08:36:43 +0200 (CEST)
Received: by mail-vk0-f44.google.com with SMTP id d12so4747392vkf.1
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 23:36:43 -0700 (PDT)
In-Reply-To: <s5hinff1fd9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2017-10-16 18:50 GMT+07:00, Takashi Iwai <tiwai@suse.de>:
> Try the git version of alsa-utils.  This issue should have been
> already addressed along with the code refactoring.
>
>
> thanks,
>
> Takashi

Yes, using current Git version fixed the problem. Thank you!

Though, this version doesn't build out of the box on my machine;
it failed in `autoheader` preprocessing step, which needs a manual edit
in `configure.ac` to work around:

configure.ac:422: error: `po/Makefile.in' is already registered with
AC_CONFIG_FILES.
../../lib/autoconf/status.m4:288: AC_CONFIG_FILES is expanded from...
configure.ac:422: the top level
autom4te: /usr/bin/m4 failed with exit status: 1
autoheader: '/usr/bin/autom4te' failed with exit status: 1

The problem seems to be the `po/Makefile.in` argument being added into
parameter list of `AC_OUTPUT()` macro call in `configure.ac` for *two times*
(instead of just once) by some step in preprocessing before `autoheader`
invocation- probably the `gettextize`.

The workaround in my case is removing an extraneous second instance
of "po/Makefile.in" in `configure.ac` before running `autoheader`
and the rest of preprocessing procedure. (I'm using the manual preprocessing
steps listed in "Compilation from git sources" section of the `INSTALL` file)

I will open a separate thread to report once I collected more information.

Regards,
Nutchanon Wetchasit

alsa-utils: v1.1.4-9-gf72a296 (git 26-Sep-2017)
libasound: 1.1.4 (source distribution)
autoconf: 2.69 (debian)
automake: 1.11.6 (debian)
gettext: 0.18.1 (debian)
System: Debian GNU/Linux 7.0 "Wheezy" i386
