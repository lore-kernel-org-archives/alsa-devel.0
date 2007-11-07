From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Audio quality issues with dmix plugin
Date: Wed, 7 Nov 2007 14:19:04 +0530
Message-ID: <61445c750711070049hf2d0f10r1acaccd6b1e2a928@mail.gmail.com>
References: <61445c750711060016y1755bd74l87cdc39718b5d226@mail.gmail.com>
	<473106E7.9050601@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C6AAC24558
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 09:49:07 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so3037621wag
	for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2007 00:49:06 -0800 (PST)
In-Reply-To: <473106E7.9050601@keyaccess.nl>
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

On 11/7/07, Rene Herman <rene.herman@keyaccess.nl> wrote:
> On 06-11-07 09:16, Pharaoh . wrote:
>
> > When I play a 44Khz file without using any ALSA plugin like
> >
> > #aplay -Dhw:0,0 44k.wav
> >
> > the sound quality is awesome but when I play the same file using dmix,
> > clicks are introduced.
> >
> > #aplay -Dplug:dmix 44k.wav
> >
> > changing period size and buffer size doesn't help. I am testing my ALSA
> > driver on an OMAP850
> > based board.
>
> dmix does 48 kHz by default. Does it sound "awesome" when you play a 48 kHz
> file directly to hw:0,0? If that also clicks, the problem will be your
> driver's handling of the 48 kHz rate -- if not, it'll be the resampling, and
> I'll probably need to bow out...
>
> Rene.
>

Hi Rene,
I changed alsa.conf so that dmix does 44.1kHz and tried, without dmix
44.1 and 48kHz files sound 'awesome' but with dmix some clicks appear
at both the rates. Going ahead, I recorded a 8Khz mono sound using my
driver and played it back without dmix, it plays without any clicks,
but use dmix and clicks appear. So basically,
clicks appear at all the sample rates with dmix and without it I could
play all the sample rate files well since my hw supports hw
upsampling.

-Pharaoh.
