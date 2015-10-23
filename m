From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix no frame clk in master
 mode
Date: Fri, 23 Oct 2015 00:48:19 -0700
Message-ID: <20151023074816.GA9024@Asurada-CZ80>
References: <2ec370890aca1bf5e8b796d7ebbfc95a0161980e.1439345935.git.zidan.wang@freescale.com>
 <20150812035317.GA3194@Asurada-CZ80>
 <20150812075914.GC21786@shlinux2> <20150812091916.GA1512@Asurada>
 <20150818020152.GA17381@shlinux2> <20150821074737.GA1796@Asurada>
 <20150821084018.GA11926@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 128C22614A4
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 09:48:26 +0200 (CEST)
Received: by padhk11 with SMTP id hk11so111457867pad.1
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 00:48:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150821084018.GA11926@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,
	Sorry for late reply.

On Fri, Aug 21, 2015 at 04:40:20PM +0800, Zidan Wang wrote:
> > > > > > > After several open/close sai test with ctrl+c, there will be I/O error.
> > > > > > > The SAI can't work anymore, can't recover. There will be no frame clock.
> > > > > > > With adding the software reset in trigger stop, the issue can be fixed.
> > 
> > > > > > It doesn't look like a decent fix to me. Is it the only fix that
> > > > > > IC team suggests? And why put this reset in the trigger function.
> > > > > > Your MEGA fast patch has already included a software reset in the
> > > > > > PM runtime functions. When dealing with CTRL+C test cases, that
> > > > > > software reset should have worked as well.
> > 
> > > > > The MEGA fast patch add the suspend/resume function, but CTRL+C will not
> > > > > trigger suspend/resume function.
> > > > > When CTRL+C, it will trigger stop and software reset SAI.
> > > > > IC team suggest us to rest it, but I don't know if it's the only fix.
> > 
> > > > You can try to add SET_RUNTIME_PM_OPS() and to see if the suspend
> > > > function is called right after pressing ctrl+c.
> > 
> > > The runtime suspend function will be call after the power down time. So if i
> > > playback again before the power down time, runtime suspend will not be called.
> > 
> > I see.. Can you provide me a test case to reproduce this issue?
> 
> 1. aplay -Dhw:0 /unit_tests/audio8k16S.wav
> 2. ctrl+c
> 
> Set SAI to master mode, then try it several times.

I've reproduced the issue and tried a few fixes but it turns out
putting a reset procedure in the trigger is seemly the only fix.
(Even using pm_runtime without power down delay does not cover
 all the test cases.)

So I suggest you first to double confirm with the IC team if the
problem is caused by defect of the internal bit clock generator
and reseting is the only option. After that, I'll accept the fix.

However, you may also need to refine your commit log and comments
in the driver for the following points:

1) This is a hardware bug/errata and reset is the only option.
2) According to the reference manual, the software reset doesn't
   reset any control register but only internal hardware logics
   such as bit clock generator, status flags, and FIFO pointers.
   (Our purpose is just to reset the clock generator while the
    software reset is the only way to do that.)
3) Since slave mode doesn't use the clock generator, only apply
   the reset procedure to the master mode.

Additionally, we may also need to take care of asynchronous mode
later as TX clock generator will not be reset when RX is still
running.

Nicolin
