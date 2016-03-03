From: Thomas Klausner <tk@giga.or.at>
Subject: Re: [PATCH] Make alsa asound.h header more portable.
Date: Thu, 3 Mar 2016 16:29:26 +0100
Message-ID: <20160303152926.GI26041@danbala.tuwien.ac.at>
References: <1457014899-19669-1-git-send-email-tk@giga.or.at>
 <sfid-H20160303-162151-+046.66-1@spamfilter.osbf.lua>
 <s5htwkn4mf7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id BCA46266631
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 16:29:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htwkn4mf7.wl-tiwai@suse.de>
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

On Thu, Mar 03, 2016 at 04:21:32PM +0100, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 15:21:39 +0100,
> Thomas Klausner wrote:
> > 
> > From: Thomas Klausner <wiz@NetBSD.org>
> > 
> > This header is used as-is in the alsa-lib userland library,
> > which is portable to other operating systems.
> > For this reason, include linux/types.h only on Linux systems.
> 
> This is needed also for building the Linux kernel.  So...
> 
> > Add sys/ioctl.h for _IOR/_IOW/etc. (works at least on *BSD and Solaris).
> > 
> > Signed-off-by: Thomas Klausner <wiz@NetBSD.org>
> > ---
> >  include/uapi/sound/asound.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> > index a82108e..3d581b5 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -23,7 +23,11 @@
> >  #ifndef _UAPI__SOUND_ASOUND_H
> >  #define _UAPI__SOUND_ASOUND_H
> >  
> > +#ifdef __linux__
> 
> ... the following might be better.
> 
> #if defined(__KERNEL__) || defined(__linux__)
> 
> At least the same style is found in include/uapi/drm/drm.h, too.

Thank you! New patch sent.
 Thomas
