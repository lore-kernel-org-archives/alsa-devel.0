From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA 1.1.8 Release - POLLRDNORM undefined
Date: Thu, 10 Jan 2019 13:24:02 +0900
Message-ID: <20190110042402.GA7696@workstation>
References: <34543a6f-8123-10e5-ea79-338b82a22818@systech.com>
 <s5htviixf0t.wl-tiwai@suse.de>
 <1e297542-0023-0a92-7407-076ee547b5d9@systech.com>
 <s5hftu1h8qg.wl-tiwai@suse.de> <s5hef9lh8ne.wl-tiwai@suse.de>
 <24afbadf-7c52-1f1c-6fcd-45a1bf8a6657@systech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50EC2267445
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 05:24:11 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id 64so4701449pfr.9
 for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2019 20:24:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <24afbadf-7c52-1f1c-6fcd-45a1bf8a6657@systech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jay Foster <jay@systech.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm an author of axfer.

On Tue, 08 Jan 2019 18:00:18 +0100, Jay Foster wrote:
> I am attempting to build the 1.1.8 release of alsa-utils and getting
> an error about POLLRDNORM (and others) undefined.=A0 This error comes
> from axfer/waiter-select.c.=A0 axfer/waiter-select.c includes
> "waiter.h", which includes "poll.h".=A0 This build is for a linux
> target.

> On Wed, 09 Jan 2019 17:22:36 +0100, Jay Foster wrote:
> > On 1/9/2019 3:10 AM, Takashi Iwai wrote:
> > > Which libc are you using?  The POSIX man page (man poll.h) mentions
> > > POLLRDNORM defined there, at least, on my system with glibc 2.27.
> >
> > This is a legacy ARM product using glibc 2.9.

I'm sorry for the FTBFS but it's out of my notice to build with too-old gli=
bc.

Here, a history of glibc for related events:
* glibc-2.9: 2008/11/13
  * your version
* glibc-2.10: 2009/5/9
  * support XPG7/POSIX-2008
  * add '__USE_XOPEN2k8' for the avove
* glibc-2.19: 2014/2/7
  * add '_DEFAULT_SOURCE' macro
  * XPG7/POSIX-2008 is a default behaviour
* glibc-2.20: 2014/9/7
  * obsolete '_BSD_SOURCE' and '_SYSV_SOURCE' macros
* glibc-2.28: 2018/8/1
  * used my environment (Ubuntu 18.10)

The macros, POLLRDNORM and the others, seems to be defined officially in
POSIX-2008 and nowadays glibc supports POSIX-2008 as a default. This is
the reason that I've never faced your issue in my development period.
I guess it's the reason that nothing noted in man of poll(2) and
select(2).

I need a bit time to judge whether it's woth to support such old-glibc.
Just removal of the newly-introduced macros is a simple solution.


Thanks for your report

Takashi Sakamoto
