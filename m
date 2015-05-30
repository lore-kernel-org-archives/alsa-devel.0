From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Realtek ALC892 / snd-hda-intel breakage between
 3.16 & 3.19
Date: Sat, 30 May 2015 20:03:01 +0800
Message-ID: <CAN8ccibgmUhwE8UJPBF4GS+Lws4F+MtWKb5e=z1DjU0T1xSTLA@mail.gmail.com>
References: <20150527190106.GA12158@dot.dmz.freshdot.net>
 <CAN8cciY_PGVKaDWpOGmaZgRetS9oQpCoPqH5PpZdVdNgrk26YQ@mail.gmail.com>
 <20150528151724.GC12158@dot.dmz.freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 by alsa0.perex.cz (Postfix) with ESMTP id E20EC260601
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 14:03:02 +0200 (CEST)
Received: by oifu123 with SMTP id u123so73773311oif.1
 for <alsa-devel@alsa-project.org>; Sat, 30 May 2015 05:03:01 -0700 (PDT)
In-Reply-To: <20150528151724.GC12158@dot.dmz.freshdot.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> > > After upgrading from 3.16.0-38-generic (Ubuntu Utopic) to
> > > 3.19.0-18-generic (Ubuntu Vivid) my audio stopped working.
> > > The issue appears to be in the snd-hda-intel driver.
> [ .. ]
> > HDMI fail because drm/i915 fail
>
> So it appears. I hadn't noticed these:
> | [000d00h02m01s] Could not create debugfs 'i915_pipe_update_start'
directory
> | [000d00h02m01s] snd_hda_intel 0000:00:03.0: Cannot turn on display
power on i915
>
>

This patch add the error messge " Cannot turn on display power on i915"

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/patch/sound/pci/hda/hda_intel.c?id=74b0c2d75fb4cc89173944e6d8f9eb47aca0c343
