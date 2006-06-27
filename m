From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: list corruption on removal of snd_seq_dummy
Date: Tue, 27 Jun 2006 08:05:01 -0400
Message-ID: <200606270808_MC3-1-C391-2F33@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
	 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932274AbWF0MLQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dave Jones <davej@redhat.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In-Reply-To: <s5hejxb7xrb.wl%tiwai@suse.de>

On Tue, 27 Jun 2006 11:28:56 +0200, Takashi Iwai wrote:

> >  > > The code in question is doing..
> >  > > 
> >  > >         __list_add(&deleted_list,
> >  > >                client->ports_list_head.prev,
> >  > >                client->ports_list_head.next);
> >  > > 
> >  > > which looks fishy, as those two elements aren't going to be consecutive,
> >  > > as __list_add expects.
> >  > 
> >  > I think the code behaves correctly but probably misusing __list_add().
> >  > It movies the whole entries from an existing list_head A
> >  > (clients->ports_list_head) to a new list_head B (deleted_list).
> >  > The above is exapnded:
> >  > 
> >  >  A->next->prev = B;
> >  >  B->next = A->next;
> >  >  B->prev = A->prev;
> >  >  A->prev->next = B;
> >  > 
> >  > Any better way to achieve it using standard macros?
> > 
> > Why can't you just list_move() the elements ?
> 
> No, list_move() can't move the whole elements without loop.
> 
> A solution is
> 
>       list_add(B, A);
>       list_del_init(A);
> 
> (although this introduces a bit more code :)

Shouldn't it be like this?

        ports_list_first = client->ports_list_head.next;
        list_del_init(client->ports_list_head);
        list_splice(ports_list_first, &deleted_list);

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
