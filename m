From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA processor usage is too high
Date: Sat, 6 Nov 2010 05:30:35 +0000
Message-ID: <20101106053034.GA27098@sirena.org.uk>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
	<4CD41528.1060600@ladisch.de>
	<AANLkTinXm2G1y477xRTc_QjXuEZ_nyAqGWuSkq32KGe2@mail.gmail.com>
	<4CD445BD.3020501@ladisch.de>
	<AANLkTi=kMF=_1u40yTtvA=oSpyyQn=nEF_JHY_NskiAw@mail.gmail.com>
	<4CD456AE.7090302@ladisch.de>
	<AANLkTi=7pEPATKneHvZ-U-v7RUe90X-YSR-fqhF3bNx6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 212F01037FF
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 06:30:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=7pEPATKneHvZ-U-v7RUe90X-YSR-fqhF3bNx6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 03:27:01PM -0400, Adam Rosenberg wrote:

> avail_update was the only reliable method.  Could you provide an
> alternative example that is known to work with multiple streams in the
> same application?

poll() is designed for this application.

> Sorry for the confusion, the main loop of my application basically does this:
> while(1)
> {
>   processNextAlsaStream();
>   processMp3Decoder();
>   processLCD();
>   processInputs();
>   processSerial();
> }

What you appear to be saying here is that your application which busy
waits is consuming a lot of CPU - this isn't entirely surprising, as
with many APIs in Linux the ALSA APIs are designed to be event driven.
If you really need to do this I'd suggest having all the functions which
can wait for input (at a guess at least the ALSA, input and serial ones)
converted to wait for events on their fds using poll(), epoll() or
whatever and if you desperately need to busy wait then do this by using
poll() on an epoll fd with a timeout of zero.  This will reduce the
overhead you incur for busy waiting.
