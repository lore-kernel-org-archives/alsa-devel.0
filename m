From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: A problem with USB audio devices and the UHCI
	scheduler
Date: Wed, 04 Jul 2012 15:43:04 +0200
Message-ID: <4FF44868.70506@ladisch.de>
References: <CACrD=+8BOOb=17Qs5k_2jZeEf_+N3U1dq2sm0PtwrWxkrouRLw@mail.gmail.com>
	<4FF33018.2050701@ladisch.de>
	<CACrD=+-NB0Lyd=BAAC7D304fUA6xj-OZOao5_9B96C5ffi2osA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 55F40104409
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 15:43:08 +0200 (CEST)
In-Reply-To: <CACrD=+-NB0Lyd=BAAC7D304fUA6xj-OZOao5_9B96C5ffi2osA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Monty Montgomery <xiphmont@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Monty Montgomery wrote:
> The device does use altsets for different sample formats and
> input/output channels, just not altsets for each sample rate (as
> supported/encouraged by the Audio Class...

Supported, but not encouraged:
| A typical use of alternate settings is to provide a way to change
| the bandwidth requirements an active AudioStreaming interface
| imposes on the USB.

> Is it really the case that other Audio Class devices never make use
> of the "multiple sample rates in an altset" feature?

They do, but not when bandwidth matters.


Regards,
Clemens
