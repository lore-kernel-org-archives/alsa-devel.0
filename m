From: Cheng Sun <chengsun9@gmail.com>
Subject: Re: 1.1.4 bug report: dmix fails when using both
 32-bit and 64-bit clients
Date: Thu, 25 May 2017 16:43:44 +0100
Message-ID: <CAG6t6sNzR1a+Z8AiDpkQry5XZ9c6qU3=X_Yz19eChy4V=Kbs=g@mail.gmail.com>
References: <CAG6t6sPK9ug-HDs9qRttQZueNUpszByYRJtnQcMLNkQNF4FJoQ@mail.gmail.com>
 <s5h8tllkpwm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 42972266D57
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 17:43:47 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id m4so21200969ioe.0
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 08:43:46 -0700 (PDT)
In-Reply-To: <s5h8tllkpwm.wl-tiwai@suse.de>
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

On 25 May 2017 14:49, "Takashi Iwai" <tiwai@suse.de> wrote:
>
> On Wed, 24 May 2017 21:13:46 +0200,
> Cheng Sun wrote:
> >
> > Hi all,
> >
> > The following commit (released in v1.1.4) introduced an issue where a
> > client compiled against a 32-bit (x86) compile of alsa-lib cannot use
> > the same dmix as a client compiled against a 64-bit alsa-lib.
> >
> >     1a9bd0f0448106b917ae7f7bedccfcbf6ce84802
> >
> > The error message is:
> >
> >     ALSA lib pcm_dmix.c:1077:(snd_pcm_dmix_open) unable to create IPC
> > shm instance
> >
> > The following forum post (not mine) describes the symptoms of the
> > issue in more detail (although the git commit the poster specified is
> > not correct):
> >
> >
https://forums.gentoo.org/viewtopic-p-8072290.html?sid=c2fbca45102933ddf9ca7cf8b6713e56
>
> There is a known problem when you mix up two alsa-lib versions because
> of the changes in dmix shmem struct.  The solution should upgrade all
> users.

(Apologies for duplicate email --accidentally sent the first reply to the
wrong address.)

Arch Linux has upgraded both its 32 and 64 bit packages to v1.1.4, and I'm
still experiencing this problem.

While bisecting the bug I linked against two compiles of the same alsa-lib
versions each time.

Let me know if I can provide any other information.

Cheers,
Cheng
