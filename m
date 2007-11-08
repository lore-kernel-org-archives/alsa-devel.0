From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Audio quality issues with dmix plugin
Date: Thu, 8 Nov 2007 12:19:16 +0530
Message-ID: <61445c750711072249k1a961cecj76cfe9edb077ade@mail.gmail.com>
References: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>
	<473106E7.9050601@keyaccess.nl>
	<61445c750711070049hf2d0f10r1acaccd6b1e2a928@mail.gmail.com>
	<47323618.7090602@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 41FFF247CF
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 07:49:19 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so104842wag
	for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2007 22:49:17 -0800 (PST)
In-Reply-To: <47323618.7090602@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 8, 2007 3:33 AM, Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 07-11-07 09:49, Pharaoh . wrote:
>
> > I changed alsa.conf so that dmix does 44.1kHz and tried, without dmix
> > 44.1 and 48kHz files sound 'awesome' but with dmix some clicks appear
> > at both the rates. Going ahead, I recorded a 8Khz mono sound using my
> > driver and played it back without dmix, it plays without any clicks,
> > but use dmix and clicks appear. So basically,
> > clicks appear at all the sample rates with dmix and without it I could
> > play all the sample rate files well since my hw supports hw
> > upsampling.
>
> Okay -- I don't even use dmix, so will defer to someone else. If there's
> anything special about your driver/hardware such as non-interleaved PCM
> and/or endianness conversions this is probably the time to say so...
>
> Rene.
>
No issues as endianness or non-interleaved pcm.
