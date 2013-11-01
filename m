From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: wm_adsp: Add support for	grouped
	ALSA binary controls
Date: Fri, 1 Nov 2013 10:46:27 +0000
Message-ID: <20131101104627.GA5396@opensource.wolfsonmicro.com>
References: <1383152069-8646-1-git-send-email-dp@opensource.wolfsonmicro.com>
 <1383152069-8646-2-git-send-email-dp@opensource.wolfsonmicro.com>
 <s5htxfxj2ly.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E2842655A0
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 11:46:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htxfxj2ly.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 31, 2013 at 08:55:53AM +0100, Takashi Iwai wrote:
> At Wed, 30 Oct 2013 16:54:29 +0000,
> Dimitris Papastamos wrote:
> > 
> > Currently the ALSA ABI imposes a hard limit of 512 bytes per binary
> > control.  To support coefficient data blocks of larger sizes we carve up
> > this space into multiple alsa controls.  All of these controls are
> > identified by a common prefix and suffix of the form ":<blk id>".
> > 
> > Control groupings can also consist of a single block in which case the
> > suffix ":0" is used.
> 
> Why not using the control element index?
> 
> You can create each kctl element individually with a different index,
> but also you can create multiple ctl elements in a single shot by
> passing to snd_kcontrol_new.count field.  This will create a grouped 
> object, thus it saves spaces, too, in comparison with individual
> kctls.  The drawback is that you need to retrieve the real index via
> snd_ctl_get_ioff*() in each control callback.

I will give this a shot when I have some time and re-send the patch.

Thanks,
Dimitris
