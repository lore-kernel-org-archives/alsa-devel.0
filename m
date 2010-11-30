From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Unable to open CAPTURE device
Date: Tue, 30 Nov 2010 16:35:50 +0100
Message-ID: <4CF519D6.8050601@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3B4@EXGMBX01.sasken.com>,
	<4CF4CA44.7010409@ladisch.de>
	<16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3C1@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 88E54244D2
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 16:33:45 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE3C1@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> But Since ipod is connected using USB interface (USB Audio Class
> device).  Wont it be treated as USB Audio capture device ?

In that case, yes.

Does the device show up in /proc/asound/cards?


Regards,
Clemens
