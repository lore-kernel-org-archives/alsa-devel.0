From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix no frame clk in master
 mode
Date: Fri, 21 Aug 2015 00:47:37 -0700
Message-ID: <20150821074737.GA1796@Asurada>
References: <2ec370890aca1bf5e8b796d7ebbfc95a0161980e.1439345935.git.zidan.wang@freescale.com>
 <20150812035317.GA3194@Asurada-CZ80>
 <20150812075914.GC21786@shlinux2> <20150812091916.GA1512@Asurada>
 <20150818020152.GA17381@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 235C52604D5
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 09:47:50 +0200 (CEST)
Received: by pdbfa8 with SMTP id fa8so23883913pdb.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 00:47:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150818020152.GA17381@shlinux2>
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

On Tue, Aug 18, 2015 at 10:01:54AM +0800, Zidan Wang wrote:

> > > > > After several open/close sai test with ctrl+c, there will be I/O error.
> > > > > The SAI can't work anymore, can't recover. There will be no frame clock.
> > > > > With adding the software reset in trigger stop, the issue can be fixed.

> > > > It doesn't look like a decent fix to me. Is it the only fix that
> > > > IC team suggests? And why put this reset in the trigger function.
> > > > Your MEGA fast patch has already included a software reset in the
> > > > PM runtime functions. When dealing with CTRL+C test cases, that
> > > > software reset should have worked as well.

> > > The MEGA fast patch add the suspend/resume function, but CTRL+C will not
> > > trigger suspend/resume function.
> > > When CTRL+C, it will trigger stop and software reset SAI.
> > > IC team suggest us to rest it, but I don't know if it's the only fix.

> > You can try to add SET_RUNTIME_PM_OPS() and to see if the suspend
> > function is called right after pressing ctrl+c.

> The runtime suspend function will be call after the power down time. So if i
> playback again before the power down time, runtime suspend will not be called.

I see.. Can you provide me a test case to reproduce this issue?
