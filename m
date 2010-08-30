From: Camilo Polymeris <cpolymeris@gmail.com>
Subject: Re: Mixer application for EMU cards
Date: Mon, 30 Aug 2010 13:41:58 -0400
Message-ID: <1283190118.9238.12.camel@aviva.ttga.homeip.net>
References: <c812bae60804150126j5258843em44849b3c5f367f8f@mail.gmail.com>
	<200804201916.00941.c.fertr@gmail.com>
	<c812bae60804202142y1d59905fib7721089fc701fef@mail.gmail.com>
	<200804242332.55916.c.fertr@gmail.com>
	<1283067601.4084.11.camel@aviva.ttga.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1877924445
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 19:43:02 +0200 (CEST)
Received: by qwj9 with SMTP id 9so5044053qwj.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 10:43:02 -0700 (PDT)
In-Reply-To: <1283067601.4084.11.camel@aviva.ttga.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Camilo Polymeris <cpolymeris@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-08-29 at 03:40 -0400, Camilo Polymeris wrote:
> Hello,
> for those of you not subscribed to LAD, I finally got to write a mixer
> application for the EMU 1010 based cards. I tossed out the original
> ideas of a full-featured app and went the simple way, just basic
> point-to-point routing, no fancy "Multichannel"  features.
> 
> It's available here: http://code.google.com/p/emutrix/
> Screenshot:
> http://www2.udec.cl/~cpolymeris/emutrix/Screenshot-EMutrix-1.png
> 
> Be aware that the code is awful, just fast prototyping, but functional.
> It may also mess with your mixer levels, if you want to try it. please
> make a backup with 'alsactl store'.
> 
> Feedback welcome,
> Camilo
> 

While writing this software I realized that the input and output pads
are actually -12dB pads, not -14dB as the driver states. I guess they
are thought as +4dBu/-10dBV (= ~12dB) switches.
Also the driver says SPDIF input is on the 0202 daughter card, but at
least in my card it's on the 1010 main card.
I have a 1212M V1 card. If anyone has one of these cards, can you
confirm that these are true for other/all cards of the series?

Thanks
Camilo
