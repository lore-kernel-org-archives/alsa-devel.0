From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - seq 1/1] ALSA: seq: Continue broadcasting
 events to ports if one of them fails
Date: Tue, 3 Jun 2014 18:33:32 -0400
Message-ID: <CAOf41NnJeMhUOTg+U6FM0UcDLsU2DNJum4=rPCOFuEH4Uc0Y1g@mail.gmail.com>
References: <1401738082-28488-1-git-send-email-agoode@google.com>
 <s5hlhtezgze.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 002E4261AB6
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 00:33:33 +0200 (CEST)
Received: by mail-ig0-f178.google.com with SMTP id h18so339941igc.5
 for <alsa-devel@alsa-project.org>; Tue, 03 Jun 2014 15:33:32 -0700 (PDT)
In-Reply-To: <s5hlhtezgze.wl%tiwai@suse.de>
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

On Tue, Jun 3, 2014 at 1:42 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon,  2 Jun 2014 15:41:22 -0400,
> Adam Goode wrote:
> >
> > Sometimes PORT_EXIT messages are lost when a process is exiting.
> > This happens if you subscribe to the announce port with client A,
> > then subscribe to the announce port with client B, then kill client A.
> > Client B will not see the PORT_EXIT message because client A's port is
> > closing and is earlier in the announce port subscription list. The
> > for each loop will try to send the announcement to client A and fail,
> > then will stop trying to broadcast to other ports. Killing B works fine
> > since the announcement will already have gone to A. The CLIENT_EXIT
> > message does not get lost.
> >
> > How to reproduce problem:
> >
> > *** termA
> > $ aseqdump -p 0:1
> >   0:1   Port subscribed            0:1 -> 128:0
> >
> > *** termB
> > $ aseqdump -p 0:1
> >
> > *** termA
> >   0:1   Client start               client 129
> >   0:1   Port start                 129:0
> >   0:1   Port subscribed            0:1 -> 129:0
> >
> > *** termB
> >   0:1   Port subscribed            0:1 -> 129:0
> >
> > *** termA
> > ^C
> >
> > *** termB
> >   0:1   Client exit                client 128
> >    <--- expected Port exit as well (before client exit)
> >
> > Signed-off-by: Adam Goode <agoode@google.com>
>
> Thanks.  The changes look OK to me, though, I'd prefer a variable name
> "result" instead of "sticky_err".  And you don't have to initialize
> err any longer there.
>
> Meanwhile, it's another question what to be returned from the
> function.  Such broadcasting case, would it be better to return always
> num_ev when it's positive, or always report any (non-serious) error?
>
>
Thanks, I will send another patch with "result" instead.

Right now, the function will always report an error if any error occurs. My
patch should not change this behavior. I believe my patch has the effect
equivalent to sorting the list such that the failed ports are all at the
end.

If you would like to change the behavior of the function, that is another
issue.


Thanks,

Adam
