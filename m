From: Klaus Schulz <kls.schlz@googlemail.com>
Subject: Re: EMU 0404USB: Odd sample rate shown during playback.
Date: Wed, 10 Jun 2009 17:33:32 +0200
Message-ID: <d9690f190906100833l3dd38d2p4f28d3334fc8b95e@mail.gmail.com>
References: <001636c5a907c27277046bd13e2e@google.com>
	<4A2CF886.7040407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id AECF2103817
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 17:33:33 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so411857ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 08:33:32 -0700 (PDT)
In-Reply-To: <4A2CF886.7040407@ladisch.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens.

Reading you answer below. Does this mean the Transit is necessarily not
running in async mode during playback of 44.1 material
even though it says so in the stream0 file?

As far as I know I can slave the Transit to an external SPDIF clock. This
would mean that in this case the Transit would slave the PC, thus working
async.

The open question is still if even without external clock the Tranist works
in async as the log is saying.

How can I find that out?

Cheers


On Mon, Jun 8, 2009 at 1:39 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> kls.schlz@googlemail.com wrote:
> > On my M-Audio Transit though it remains 44.1 even though it says "async"
> at
> > 16/44.1 in the stream0 file.
>
> It could have a clock that happens to run at the same speed as your
> computer's.  Or it could be that it runs the ADC synchronously to the
> computer but says "async" so that it can deliver recorded SPDIF data at
> the source's speed.
>
>
> Best regards,
> Clemens
>
