From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH v4 14/15] ALSA: usb-audio: always wait in
 start_endpoints
Date: Tue, 8 Oct 2013 21:25:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310082112490.1364@anubis>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
 <1381091480-23636-15-git-send-email-eldad@fogrefinery.com>
 <s5hfvsdsa8n.wl%tiwai@suse.de> <alpine.LNX.2.00.1310072111050.11043@anubis>
 <s5hbo30jl9c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BA082610C4
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2013 21:25:24 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id mz13so3386693bkb.2
 for <alsa-devel@alsa-project.org>; Tue, 08 Oct 2013 12:25:24 -0700 (PDT)
In-Reply-To: <s5hbo30jl9c.wl%tiwai@suse.de>
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
Cc: Nikolay Martynov <mar.kolya@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Tue, 8 Oct 2013, Takashi Iwai wrote:

> At Mon, 7 Oct 2013 21:26:57 +0200 (CEST),
> Eldad Zack wrote:
> > 
> > 
> > 
> > On Mon, 7 Oct 2013, Takashi Iwai wrote:
> > 
> > > At Sun,  6 Oct 2013 22:31:19 +0200,
> > > Eldad Zack wrote:
> > > > 
> > > > Start the endpoints at prepare also for capture endpoints,
> > > > since it might be needed to wait for the URBs to be unlinked.
> > > > 
> > > > If an implicit feedback source endpoint stops being used by its
> > > > sink endpoint, but immediately used as a data endpoint, usb_submit_urb
> > > > will return -EBUSY.
> > > > 
> > > > Merge two trigger cases since they are now the same.
> > > This change worries me about the timing.  This change means that the
> > > capture stream isn't started at the moment the trigger callback is
> > > called but at the next urb handling.  It means a possible regression
> > > in the case of realtime usage.
> > 
> > I'm not sure I understand. Do you mean it might cause the delay between 
> > capture and playback to vary at each startup?
> 
> No, I mean that the actual begin of the recording will be delayed in
> comparison with the driver without your patch.  The delay can't be
> avoided in this style.

Ah. I see what you mean.

> > > Is there any reason to do this except for clean up?  IOW, does this
> > > fix any problem by itself?
> > 
> > Yes, I only became aware of it since I bumped into it with my test tool.
> > Attached here - I hope the mailing list accepts attachments.
> 
> I understand that this will be required for the implicit feedback
> case.  But why applying this to *all* other cases, too, although we
> know that this may regress slightly with respect to the latency?
> This is my biggest concern.

Yes, I understand now. I'll of course change that along with all the 
rest and post a new set.
Thanks!

Cheers,
Eldad
