From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Re: Possible message repeat
Date: Mon, 25 Jun 2012 08:02:58 -0700
Message-ID: <CAAo96ZDB3GvZFLCnpL1Yyi-Gr=+S08K21ZwFDT5aPnfR=Rnwxg@mail.gmail.com>
References: <CAAo96ZA3=A2cxTPR5Yegoaru88fKAJx277kdSqS+i9vJ8JA=tg@mail.gmail.com>
	<4FE83418.7090401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f49.google.com (mail-yw0-f49.google.com
	[209.85.213.49]) by alsa0.perex.cz (Postfix) with ESMTP id 4F8A3244AE
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2012 17:02:59 +0200 (CEST)
Received: by yhjj52 with SMTP id j52so3847270yhj.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2012 08:02:58 -0700 (PDT)
In-Reply-To: <4FE83418.7090401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens.  I just wanted to clarify the situation.  It seemed you were
hinting at the possibility, but I was not 100% sure.  Thank you for
clearing that up.

On Mon, Jun 25, 2012 at 2:49 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Brent Weatherall wrote:
> > our goal is to specify a special XU that WOULD require vendors
> > supporting it to modify their firmware.  We fully expect a vendor to
> > modify their firmware to support our specification.  That being said,
> > is there a simple way to use ALSA to communicate with a vendor
> > specific XU as long as the software understands the XU?  For example,
> > in the video4linux2 world, we can specify a UVC XU with a set of
> > controls for special processing, then vendors that want to support it
> > modify their firmware to support it.  Then anyone can use our custom
> > user-space drivers to easily talk to the video device.  V4L2 has
> > controls made for using XUs in this manner.
>
> The audio class specification does not define any mechanism for a device
> to specify what those controls would be.  And because nobody has ever
> needed to use XUs so far, the current ALSA driver has no other way to
> create such controls.
>
> If you insist on not changing ALSA, you must bypass it.
>
>
> Regards,
> Clemens
>
