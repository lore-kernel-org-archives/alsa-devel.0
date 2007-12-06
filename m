From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Making ALSA apps run on OSS driver
Date: Thu, 6 Dec 2007 17:13:10 +0530
Message-ID: <61445c750712060343m14466ac0qb07cdc46e16fadaf@mail.gmail.com>
References: <61445c750712060056w23b00084j5e5c6a30f1d38bc7@mail.gmail.com>
	<1196940872.19688.1225129847@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id E4644244EF
	for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2007 12:43:13 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so486039wag
	for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2007 03:43:12 -0800 (PST)
In-Reply-To: <1196940872.19688.1225129847@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 6, 2007 5:04 PM, Clemens Ladisch <cladisch@fastmail.net> wrote:

> Pharaoh . wrote:
> > I have heard about OSS emulation in ALSA i.e. any read/write to /dev/dsp
> will go to my ALSA driver
> > but is there any way to do the reverse i.e. apps using ALSA interface
> should somehow talk to OSS
> > driver?
>
> The alsa-plugins package has the "oss" plugin for this:
>
> http://hg.alsa-project.org/alsa-plugins/raw-file/878b7784425c/doc/README-pcm-oss
>
>
> HTH
> Clemens
>

Yeah, I got it already...and this just works !! No hassles!!

-Pharaoh.
