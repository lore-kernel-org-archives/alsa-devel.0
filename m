From: Matthew Garrett <matthew.garrett@coreos.com>
Subject: Re: [PATCH] ALSA: hda - make power_save threshold per-codec
Date: Wed, 8 Apr 2015 23:24:52 -0700
Message-ID: <CAPeXnHv6UtRgvXb6b9hU_V8==cabKXsAsMi5U1MrAN5uPoXZ6A@mail.gmail.com>
References: <1428544428-6351-1-git-send-email-mjg59@coreos.com>
	<s5ha8yh7u8z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha8yh7u8z.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 8, 2015 at 10:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed,  8 Apr 2015 18:53:48 -0700,
> Matthew Garrett wrote:
> >
> > Modern hardware will often have multiple HDA devices, and the desired
> > power saving configuration may vary depending on the codecs attached to
> > each of them. Push the power_save value down to the individual codec
> > structures, keeping the module parameter as a global control mechanism
> > for compatibility purposes.
>
> This patch doesn't apply any longer at all to the recent code, since
> the power saving stuff has been already translated to the standard
> runtime PM.  Take a look at linux-next tree.

Ah! Wonderful!

> Also we can't break the current behavior controlling the power save
> via option.  Many programs rely on this mechanism, thus changing this
> would break its behavior.

Yeah, I kept that behaviour - anything that touches
/sys/module/snd_hda_intel/parameters/power_save just changes the
settings for all codecs.

> In the latest code, the common control via power_save module option is
> still there for compatibility, but you can also adjust the value for
> each codec in runtime attribute of each codec sysfs in addition.

That's ideal - I'll pull down next and rewrite my udev rules. Thanks!
