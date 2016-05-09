From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Subject: Re: Kernel config issue: SND_HDA_RECONFIG depends
	on	SND_HDA_HWDEP
Date: Mon, 09 May 2016 17:46:52 +0200
Message-ID: <1462808812.31078.17.camel@maxwell>
References: <1462550104.28105.40.camel@maxwell>
 <s5h1t5bquts.wl-tiwai@suse.de> <s5hy47jpfmc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B8782654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 17:46:56 +0200 (CEST)
In-Reply-To: <s5hy47jpfmc.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mo, 2016-05-09 at 14:42 +0200, Takashi Iwai wrote:
> Basically, the reconfig itself may be performed without hwdep in the
> recent version, e.g. triggered by the patch firmware.  So, the commit
> decoupled the hwdep and the reconfig parts individually.  If people
> needs the manual reconfig via sysfs, it still needs SND_HDA_HWDEP,
> yes.  But it's not mandatory for doing the reconfig via patch.
> 
> That said, reverting the kconfig dependency doesn't sound right in
> this case.  Instead, we need to correct and enhance the help text in
> Kconfig for avoiding the misunderstanding.
> 
> Does the patch below clarify enough?
> 

That's fine. It will help build custom kernels like I have to do.

Thanks.
-Jochen
