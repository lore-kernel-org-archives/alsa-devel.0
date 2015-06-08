From: Dan Nicholson <nicholson@endlessm.com>
Subject: Re: [PATCH] alsactl: Try to create state file directory
Date: Mon, 8 Jun 2015 05:52:18 -0700
Message-ID: <CAJAOzpBuEC5=5p3-aChEf3dqWC4TXsK=JV5jzKp7u09Ju2Y2Xg@mail.gmail.com>
References: <1433541647-300-1-git-send-email-nicholson@endlessm.com>
 <s5hpp56ig55.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AAA02602AD
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:52:22 +0200 (CEST)
Received: by pacyx8 with SMTP id yx8so59879479pac.2
 for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2015 05:52:18 -0700 (PDT)
In-Reply-To: <s5hpp56ig55.wl-tiwai@suse.de>
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

On Jun 8, 2015 4:38 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
>
> At Fri,  5 Jun 2015 15:00:47 -0700,
> Dan Nicholson wrote:
> >
> > Try to create the directory for the state file when saving so we don't
> > depend on it being created ahead of time. This only checks for failures
> > on existing directories and doesn't try to create the leading
> > directories or workaround any other errors. This should catch the common
> > case where /var/lib exists, but /var/lib/alsa doesn't.
>
> I don't think it's the role of alsactl.  It saves a file on the
> certain directory.  If it doesn't exist, it's a failure of the
> installed package.

Sure, that's understandable, but there's a couple reasons I think this is
helpful addition.

First, if no path is supplied, store will save to /var/lib/alsa. So, it's
not as of the user has supplied a path it didn't setup correctly. It would
be nice if alsactl worked out of the box without additional integration by
packagers.

Second, my real motivation for fixing this is to support stateless type of
systems that come with a clean /var. At Endless we're using ostree. The OS
is composed by Debian packages, and indeed alsa-utils is setup to create
/var/lib/alsa on install. However, to use the same OS snapshot for all
users, the contents of /var are stripped since they represent local system
state. We can certainly add a method for creating the directory at runtime,
but we believe it's more robust to have the program manage its own state as
much as possible.

Thanks,
Dan
