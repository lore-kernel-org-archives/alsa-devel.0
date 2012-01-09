From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] Revert "ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC"
Date: Mon, 9 Jan 2012 17:38:59 +0800
Message-ID: <CAF+7xWmqEP3w-cs0GhnLtSUBPxF83VC6ayd2U+NcUZuLFtFDUw@mail.gmail.com>
References: <1326079783.2951.1.camel@phoenix>
	<20120109041545.GK29065@opensource.wolfsonmicro.com>
	<CAF+7xW=o2NuHZ4joJ7z-JWaA5n7gDpuHKcqHFwsE4f2TBT8CVw@mail.gmail.com>
	<20120109062342.GN29065@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE56C1039E0
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 10:39:20 +0100 (CET)
Received: by lago2 with SMTP id o2so1233284lag.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 01:39:20 -0800 (PST)
In-Reply-To: <20120109062342.GN29065@opensource.wolfsonmicro.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/1/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 09, 2012 at 12:40:35PM +0800, Axel Lin wrote:
>
>> I think this patch reverts the problematic patch.
>> And then you can apply [PATCH] ASoC: Fix build dependency for
>> SND_AT91_SOC_AFEB9260 (
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/047861=
.html
>> )
>
> What I asked for here was a patch which brings the tree to the desired
> state. =A0Clearly I can just run git revert myself if I want to...

I misunderstand what you mean.
Now a new patch is on the way.

Thanks,
Axel
