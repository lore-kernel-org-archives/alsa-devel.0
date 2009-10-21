From: Barry Song <21cnbao@gmail.com>
Subject: Re: ASoC updates for 2.6.33
Date: Wed, 21 Oct 2009 13:00:01 +0800
Message-ID: <3c17e3570910202200u7c7d9672s194c6fbf7142effa@mail.gmail.com>
References: <20091015144039.GB24756@rakim.wolfsonmicro.main>
	<3c17e3570910200813v6ed8620je1e16fff306a00a5@mail.gmail.com>
	<20091020151713.GA5945@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220])
	by alsa0.perex.cz (Postfix) with ESMTP id E6B6E10381E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 07:00:24 +0200 (CEST)
Received: by gxk20 with SMTP id 20so7256033gxk.12
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2009 22:00:23 -0700 (PDT)
In-Reply-To: <20091020151713.GA5945@rakim.wolfsonmicro.main>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2009 at 11:17 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 20, 2009 at 11:13:19PM +0800, Barry Song wrote:
>
> No new text?
:-)
Just feel strange why s3c64xx-i2s.c/.h for s3c64xx soc are placed into
s3c24xx directory since s3c24xx can't cover s3c64xx.
There are 3 plat-xx in arch/arm:
plat-s3c/     plat-s3c24xx/ plat-s3c64xx/
and several mach-s3cxx in arch/arm:
mach-s3c2400/ mach-s3c2410/ mach-s3c2412/ mach-s3c2440/ mach-s3c2442/
mach-s3c6410/...
All these show those SoCs are equal.

Is it the time to rename sound/soc/s3c24xx/ to sound/soc/s3c or move
s3c64xx stuff to sound/soc/s3c64xx/?

>
