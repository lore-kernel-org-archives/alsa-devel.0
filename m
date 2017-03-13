From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 0/7] DisplayPort audio support on
	Cherrytrail
Date: Mon, 13 Mar 2017 09:33:57 +0100
Message-ID: <20170313083357.7i5h4ob4a5sxlb5g@phenom.ffwll.local>
References: <20170131213649.13689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 67A5A265823
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 09:34:00 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id u108so19101968wrb.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 01:34:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170131213649.13689-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, rakesh.a.ughreja@intel.com, Jerome Anand <jerome.anand@intel.com>, Daniel Vetter <daniel@ffwll.ch>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 31, 2017 at 10:36:42PM +0100, Takashi Iwai wrote:
> Hi,
> 
> the following patches enable DisplayPort Audio on Cherrytrail machines
> when applied on top of my topic/intel-lpe-audio branch.  Tests of DP
> audio were run on Dell Wyse 3040.  The regression test were performed
> on Baytrail (Compute Stick) and Cherrytrail (Zotac PI330) in HDMI
> mode.  On Cherrytrail there were no issues changing between HDMI and
> DP connectors dynamically.
> 
> Could you i915 people review and give ACK if they are OK?
> The changes in drm/i915 side are fairly trivial, so I'd like to take
> them through sound git tree once after I receive your ACKs.
> 
> 
> Changes since RFC:
>  - reordered and squashed patches
>  - clean-up of register definitions and offsets (based on feedback from
>    Jani/Ville)
>  - unmute amp for both HDMI and DP unconditionally
>  - mute amp on invalid ELD (unplug)
>  - remove test for chicken bit which seems to have no effect in hardware
>  - cosmetic edits to make checkpatch happy
>  - change i915 notification argument to pass the plataform device
>    instead
> 
> 
> Most of hard work in this patchset has been done by Pierre, so all
> credits go to him.

Please build the htmldocs and fix the new fallout these patches create:

$ make   DOCBOOKS="" htmldocs

0day should be reporting these (if it scans your mailing list), but
there's been a hiccup recently.

Good docs matter and all that ...

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
