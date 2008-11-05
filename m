From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-driver 1.0.18 doesn't built on PPC 2.6.27	and
	2.6.28
Date: Wed, 5 Nov 2008 21:45:14 +0100
Message-ID: <20081105204514.GA3574@aragorn.home.lxtec.de>
References: <s5hfxm6kuci.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 50F3B244E0
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 21:45:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxm6kuci.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai [081105 17:40 +0100]
> At Wed, 05 Nov 2008 08:56:33 +0100,
> I wrote:
[...]
> > How about the patch below?
> 
> Apparently not enough.
> I fixed now my git tree, so that it works at least for 2.6.28 x86*.
> Hopefully this also fixes PPC issues.

Thanks a lot Takashi. I've testet the latest snapshot (081105) on
x86|powerpc 2.6.2[6-8]. Builds fine. So are you going to release a
alsa-driver-1.0.18a? This is because we want to distribute that
package in DEBIAN. A patch against your latest snapshot is too much,
though. Please notice, that the actual release buils only on <=
2.6.26 and on >2.6.26 only at arch x86. Else should your snapshot
hopefully built on all arch/$ARCH/include. Isn't that reasonable?

Many thanks for cooperation.

For the DEBIAN ALSA maintainers:
Elimar

-- 
  It's a good thing we don't get all 
  the government we pay for.
