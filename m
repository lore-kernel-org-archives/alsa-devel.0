From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 2/3] snd/hda: Track the
	display_power_status using a cookie
Date: Mon, 14 Jan 2019 21:11:48 +0000
Message-ID: <154750030826.28151.3043366685556950237@skylake-alporthouse-com>
References: <20190114173753.472-1-chris@chris-wilson.co.uk>
 <20190114173753.472-2-chris@chris-wilson.co.uk>
 <s5hbm4ji0qn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D4FE2670AC
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 22:11:59 +0100 (CET)
In-Reply-To: <s5hbm4ji0qn.wl-tiwai@suse.de>
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
Cc: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2019-01-14 17:54:08)
> On Mon, 14 Jan 2019 18:37:52 +0100,
> Chris Wilson wrote:
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index b4fa1c775251..39761120ee76 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -366,8 +366,8 @@ struct hdac_bus {
> >  
> >       /* DRM component interface */
> >       struct drm_audio_component *audio_component;
> > -     long display_power_status;
> > -     bool display_power_active;
> > +     unsigned long display_power_status;
> 
> You don't need to change this field.  It's irrelevant with this patch
> itself.

It kept the length of the two variables the same, while matching the
type as used with set_bit/clear_bit :)
-Chris
