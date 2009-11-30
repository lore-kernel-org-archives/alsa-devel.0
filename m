From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb- interface - HID type
Date: Mon, 30 Nov 2009 13:46:03 +0100
Message-ID: <4B13BE8B.8050707@ladisch.de>
References: <1257435101.25623.1.camel@localhost>	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>	<20091113145050.GC30966@sirena.org.uk>	<1259536602.3374.129.camel@gnutoo-desktop>	<1259538217.24419.1.camel@gnutoo-desktop>
	<4B135345.1030906@india.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3BC1E10382E
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 13:46:08 +0100 (CET)
In-Reply-To: <4B135345.1030906@india.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: M R Swami Reddy <swami@india.nsc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

M R Swami Reddy wrote:
> Could you please suggest, if the usb interface HID class could be used 
> for sending Audio and PCM signals?

No; audio data should be transferred using isochronous transfers, and
the HID class does not use those.

Is there any reason why you cannot use a standard audio class interface?


Best regards,
Clemens
