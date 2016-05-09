From: Jochen Henneberg <jh@henneberg-systemdesign.com>
Subject: Re: Kernel config issue: SND_HDA_RECONFIG depends
	on	SND_HDA_HWDEP
Date: Mon, 09 May 2016 14:42:52 +0200
Message-ID: <1462797772.31078.2.camel@maxwell>
References: <1462550104.28105.40.camel@maxwell> <s5h1t5bquts.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3892659BC
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 14:42:56 +0200 (CEST)
Received: from [100.70.189.7] ([109.47.1.131]) by mrelayeu.kundenserver.de
 (mreue002) with ESMTPSA (Nemesis) id 0MEOIC-1aooJ40lhI-00FRf1 for
 <alsa-devel@alsa-project.org>; Mon, 09 May 2016 14:42:54 +0200
In-Reply-To: <s5h1t5bquts.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mo, 2016-05-09 at 14:28 +0200, Takashi Iwai wrote:
> On Fri, 06 May 2016 17:55:04 +0200,
> Jochen Henneberg wrote:
> > 
> > Hi,
> > 
> > with kernel 4.5 (and it looks as if this has not changed since then)
> > the SND_HDA_RECONFIG sysfs entries still show up in the hwdep devices.
> > Enabling SND_HDA_RECONFIG without SND_HDA_HWDEP is worth nothing, but
> > the dependency has been removed from Kconfig.
> > The commits from 13aeaf68 / 'Manage each codec instance individually'
> > read as if the sysfs entries should show up at the codec
> > driver but they do not.
> 
> Right, it's indeed missing in the core hdaudio bus sysfs.  We may
> extend hdaudio bus sysfs for additional entries, but I guess it's
> easier to fix up the Kconfig dependency for now.

That's true, Kconfig is the fast path. But after all, this is all worth
nothing as long as the reconfig is broken, please refer to my email
'bug: reconfig broken on kernel 4.5' in the list. I would really like to
provide a patch for this issue, but my understanding of the HDA/sound
stack is too limited.

Regards,
Jochen

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Henneberg - Systemdesign
Jochen Henneberg
Loehnfeld 26
21423 Winsen (Luhe)
--
Fon: +49 4174 668 773
Mobile: +49 172 160 14 69
Fax: +49 321 210 761 64
www: www.henneberg-systemdesign.com
