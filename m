From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Rewrite of hw_ptr updaters makes things worse?
Date: Tue, 14 Apr 2009 16:22:51 -0400
Message-ID: <20090414162251.1e565b86@dhcp-100-2-144.bos.redhat.com>
References: <20090401184627.5034c20d@dhcp-100-2-144.bos.redhat.com>
	<s5heivv2w5u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C47B24467
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 22:23:25 +0200 (CEST)
In-Reply-To: <s5heivv2w5u.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 15:37:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 1 Apr 2009 18:46:27 -0400,
> Chuck Ebbert wrote:
> > 
> > After adding these patches from 2.6.30 to a 2.6.29 kernel, pulseaudio problems
> > are worse:
> > 
> > ALSA: pcm - Reset invalid position even without debug option
> > ALSA: pcm - Fix delta calculation at boundary overlap
> > ALSA: pcm - Safer boundary checks
> > ALSA: Rewrite hw_ptr updaters
> 
> Hrm, these patches are basically to avoid reporting bogus hw_ptr
> values to the user-space.  So, the problem could be really the bad
> DMA pointer reporting on your hardware.  What shows if you enable
> the debug via
> 	# echo 1 > /proc/asound/card0/pcm0p/xrun_debug
> ??  Note that this file appears when built with
> CONFIG_SND_PCM_XRUN_DEBUG.
> 
> Jaroslav made some patches to handle the bogus DMA-pointer values.
> Could you check sound git tree below, either for-next or master
> branch?
> 

Those patches seem to have fixed things.
