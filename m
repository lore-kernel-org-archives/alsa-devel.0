From: Yogesh Soni <yksoni@gmail.com>
Subject: Re: [PATCH]: No sound when using software based mmap
	support and dmix plugin
Date: Thu, 21 May 2015 14:48:00 -0700
Message-ID: <CAHK=agvr7-Yvbns1GbbwbhbOiTh1P-NMjxTD6Fa9kC2O6fuJSA@mail.gmail.com>
References: <CAHK=aguXV_4zK+=FBmrMKZrVmBPSMoCdVvdK_P9i0HQVJXPcrw@mail.gmail.com>
 <s5hfv6szt4w.wl-tiwai@suse.de>
 <CAHK=agsOJnT6DSYDZHVjYez4PY9JYjERfvikNeSeG+xfP0uP_g@mail.gmail.com>
 <s5h617m5sib.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
 [209.85.192.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ACFB2658ED
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 23:48:01 +0200 (CEST)
Received: by qgew3 with SMTP id w3so312023qge.2
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 14:48:00 -0700 (PDT)
In-Reply-To: <s5h617m5sib.wl-tiwai@suse.de>
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

Yes Takashi. You are right. Freewheeling mode doesn't necessarily mean that
appl_ptr is invalid. I conveniently used stop_threshold check,  to infer if
dmix plugin is being used. I am definitely looking for a cleaner way to do
this. Would there be any negative implications (performance or otherwise)
of relying on xrun status? The diff should contain bytes_to_copy, instead
of a boolean value, right?

Thanks
Yogesh

On Wed, May 20, 2015 at 11:55 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 19 May 2015 11:14:13 -0700,
> Yogesh Soni wrote:
> >
> > Hi Takashi,
> >
> > Thanks for your reply. Please consider the following snippet from
> > pcm-indirect.h.  When using other plugins (like softvol), appl_ptr was
> > updated correctly and below code worked well. In case of dmix, The
> samples
> > are never copied to substream because
> >    appl_ptr = rec->appl_ptr = diff = 0  --> rec->sw_ready = 0 .
> >
> > *snd_pcm_sframes_t diff = appl_ptr - rec->appl_ptr;*
> > .....
> > if (*diff*) {
> > .......
> > rec->sw_ready += (int)frames_to_bytes(runtime, diff);
> > .......
> > }
> >  while (rec->hw_ready < qsize &&* rec->sw_ready > 0*) {
> >  *copy(substream, rec, bytes);*
> >          }
>
> I see.  But, the free wheeling mode doesn't mean that appl_ptr is
> always invalid.  It means nothing but we don't do any xrun checks and
> keeps the stream running.
>
> So, instead of checking only the stop_threshold, how about to check if
> it's in xrun, and then use it as diff?
>
>
> thanks,
>
> Takashi
>
>
> >
> > Regards
> > Yogesh
> >
> > On Tue, May 19, 2015 at 4:47 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Wed, 13 May 2015 17:12:33 -0700,
> > > Yogesh Soni wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I am trying to have dmix plugin work ( I succeeded) with the audio
> card
> > > > that does not have hardware mmap support and uses pcm_indirect
> method to
> > > > map software buffer for mmap feature.
> > > >
> > > > Most of the plugins were working quite well with mmap/pcm_indirect
> combo.
> > > > However, dmix plugin did not work (no sound). I debugged and realized
> > > that
> > > > appl_ptr in pcm_direct.h(snd_pcm_indirect_playback_transfer()) was
> > > always 0
> > > > and hence nothing got copied to slave pcm buffer. I then discovered
> that
> > > > dmix operates in freewheeling-mode..
> > > >
> > > > I have made a small workaround patch (I believe it can be cleaned
> up) in
> > > > case of free-wheeling mode, basically using sw_ready to hold bytes
> that
> > > > need to be copied. I used rec->sw_ready because it looked safest to
> use
> > > for
> > > > this purpose. As a result of this patch, normally period_size bytes
> are
> > > > copied to pcm buffer every period and sound is playing smooth.
> > > >
> > > > I am a noob in alsa and linux in general. So, I would like your
> opinion
> > > on
> > > > the patch. I would much prefer if I could write a patch that is
> generic
> > > and
> > > > clean enough, so that it could be used by others. patch is attached.
> > >
> > > Thanks for reporting and the patch.
> > >
> > > So, what actually prevents working with the current code in the free
> > > wheeling mode?
> > >
> > >
> > > Takashi
> > >
> > [2  <text/html; UTF-8 (quoted-printable)>]
> >
>
