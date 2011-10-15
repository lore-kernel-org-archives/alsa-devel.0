From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creative X-Fi 51 Pro Support
Date: Sat, 15 Oct 2011 23:58:57 +0200
Message-ID: <4E9A0221.8040508@ladisch.de>
References: <20111015141645.203040@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id C1E71246C3
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 23:59:38 +0200 (CEST)
In-Reply-To: <20111015141645.203040@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Hoff <Christian_Hoff@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian Hoff wrote:
> I just bough and installed a new Creative X-Fi 51 Pro USB sound card.
> The card works, but it recognized as a full speed 1.1 device instead
> of high speed (usb 2.0).
>
> I would like to fix this in ALSA - probably some kind of vendor-
> specific quirk is needed which tells the card that it can safely turn
> on its high-speed capabilities.

The Audigy 2 NX works like that.

> Now what I would need is some sort of technical input from Creative.

The Audigy 2 NX boot quirk was reverse engineered.


Regards,
Clemens
