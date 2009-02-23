From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: PCM delay compensation
Date: Mon, 23 Feb 2009 17:24:32 +0100
Message-ID: <20090223162431.GB22083@tango.0pointer.de>
References: <s5h4p3ol8ui.wl%tiwai@suse.de>
	<20090221234502.GA8504@tango.0pointer.de>
	<s5hiqn14mvr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B8E244D7
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 17:24:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqn14mvr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 23.02.09 08:45, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Sun, 22 Feb 2009 00:45:04 +0100,
> Lennart Poettering wrote:
> > 
> > On Tue, 07.10.08 17:32, Takashi Iwai (tiwai@suse.de) wrote:
> > 
> > > Hi,
> > 
> > Sorry for the overly long delay.
> > > 
> > > the patch below (to the latest sound git tree) adds the extra delay
> > > count for USB-audio driver.  This change will appear as the return
> > > value of snd_pcm_delay().
> > > 
> > > Could you check whether it's appropriate behavior you've wanted?
> > 
> > I have now tested this patch on the current 2.6.29-rc5 kernel. The
> > effect is that snd_pcm_delay() returns always increasing values, as if
> > the playback never proceeds. Most movie players which need that call
> > to synchronize video frames hence stall completely.
> 
> OK, that's bad.  However, the increased value of snd_pcm_delay() is
> exactly the effect.  The usb-audio always prefetch the buffer in
> advance.
> 
> That means, changing (or "fixing") snd_pcm_delay() would cause many
> regressions with many apps -- thus basically we are not allowed to
> change the semantics any more at this too late point.
> 
> I feel it's better to introduce another kernel-side API to give a
> better sync/timing information, and mark snd_pcm_delay as obsolete for
> future (although we can never deprecate such a basic API).

No, snd_pcm_delay() with this patch is clearly broken: it apparently
increases at the same speed as the hw ptr, ignoring the app
ptr. i.e. after 5 min of playback the delay will be reported a 5 mins!
After 10 min of playback the delay will be reported as 10 mins!

This is *not* a simple incompatibility with mplayer. The patch is
borked.  This has nothing to do with changing semantics and creating
incompatibilities.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
