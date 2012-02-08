From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 1/15] sound/soc/mxs/mxs-saif.c: add missing
	iounmap
Date: Wed, 8 Feb 2012 18:18:03 +0800
Message-ID: <CAA+hA=Qu0z15vkskBOZdnEMqxmOV5Dk-gmA1ZJtJtuY0e=MRFA@mail.gmail.com>
References: <1326362117-29371-1-git-send-email-Julia.Lawall@lip6.fr>
	<7FE21149F4667147B645348EC605788508FBDB@039-SN2MPN1-013.039d.mgd.msft.net>
	<alpine.DEB.2.02.1201241828480.1779@localhost6.localdomain6>
	<20120124202203.GD1135@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201242144580.1998@hadrien>
	<20120126110506.GB2611@pengutronix.de>
	<alpine.DEB.2.02.1201261220460.1851@localhost6.localdomain6>
	<20120126112242.GA9401@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1201280801230.2045@hadrien>
	<20120206162017.GM3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 84701245BE
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 11:18:05 +0100 (CET)
Received: by yhr47 with SMTP id 47so100842yhr.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 02:18:03 -0800 (PST)
In-Reply-To: <20120206162017.GM3070@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 7, 2012 at 12:20 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jan 28, 2012 at 08:03:34AM +0100, Julia Lawall wrote:
>
>> patch against
>> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> Hrm, I know there had been some debate about what to generate against
> but this now once again fails to apply against for-3.4... =A0No idea
> what's going on there and I didn't investigate the conflicts, sorry.
>
> I had been waiting in the vauge hope that some of the mxs maintainers
> would review.
>
I also failed to apply it against for-3.4.
It seemed the conflicts are a lot.

Hi Julia,

Can you regenerate the patch based on Mark's for-3.4 branch?

BTW, i wonder if this patch's title should be changed a bit
since what this patch does is not adding missing iounmap anymore.
Maybe like: ASoC: mxs-saif: convert to use devm_kmalloc and its friends.

Regards
Dong Aisheng
