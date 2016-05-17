From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] alsa-lib:Make snd_atomic_write_* truly
 atomic
Date: Tue, 17 May 2016 15:29:33 +0200
Message-ID: <alpine.DEB.2.02.1605171440470.31333@lnxricardw1.se.axis.com>
References: <570E2279.7060809@axis.com> <s5hwpo14o0n.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121446220.31333@lnxricardw1.se.axis.com>
 <s5h37pnctrf.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121556390.31333@lnxricardw1.se.axis.com>
 <s5hmvnvbafu.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605131426000.31333@lnxricardw1.se.axis.com>
 <s5hposq9lsi.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605171053010.31333@lnxricardw1.se.axis.com>
 <s5hr3d07u48.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2798226148F
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 15:29:41 +0200 (CEST)
In-Reply-To: <s5hr3d07u48.wl-tiwai@suse.de>
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
Cc: =?ISO-8859-15?Q?Arvid_Nihlg=E5rd_Lindell?= <arvidnl@axis.com>, Andreas x Larsson <andrelan@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 17 May 2016, Takashi Iwai wrote:

> There is a manual lock loop with snd_atomic_read_wait(), as found in
> pcm_plugin.c.  So, removing the stuff may potentially damage some apps
> that wrongly assume the thread safety.

Yes, I think could be true. Certainly GStreamer seems to assume this.

> Now I've been considering this issue again, I'm inclined to suggest:
> let's begin with deprecating the atomic stuff there, but opt-in via
> via a configure option for a while, in case someone still really needs
> it.
> =

> By making it optional, it's fine to take your patch and cleanup the
> old code.  Then we don't have to think of the compatibility with the
> old toolchain so much.

I'm trying to consider how this would be done in practice. Basically, add =

a configuration option like '--with-atomic' with the codec in iatomic.h =

looking something like:

  static __inline__ void snd_atomic_write_begin(snd_atomic_write_t *w)
  {
+ #ifdef USE_ATOMIC
+   __atomic_add_fetch(&w->begin, 1,__ATOMIC_SEQ_CST);
+ #else
-   w->begin++;
+ #endif
-   wmb();
  }

Thus removing the (useless?) wmb() in any case, and going to w->begin++ in =

the non-atomic case, and __atomic_add_fetch() in the atomic case?

However, this does mean that those that need/expect atomic operations must =

explicitly add a new configuration option, but perhaps that is ok, as one =

could argue that the applications that need it are buggy to start with. =


Also, it would prohibit building the building of alsa-lib for such =

applications with gcc < 4.7 (when __atomic_add_fetch was introduced), but =

perhaps that's more of an incentive than anything else. :-)

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
