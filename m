From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Newbie needs help to understand
	SNDRV_PCM_TRIGGER_START?
Date: Tue, 19 Oct 2010 15:03:41 +0200
Message-ID: <4CBD972D.3090603@ladisch.de>
References: <AANLkTi=LftOiqPhFKsc-uxPUabLZuyhcgzB4XNsSBLr7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E8B6510387B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 15:02:34 +0200 (CEST)
In-Reply-To: <AANLkTi=LftOiqPhFKsc-uxPUabLZuyhcgzB4XNsSBLr7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radivoje Jovanovic wrote:
> ALSA hits trigger method in my driver and soon after it leaves my trigger
> method throws an null pointer exception

What code hits a NULL pointer?

> I am wondering if the ALSA will call SNDRV_PCM_TRIGGER_START every single
> time new buffer is available.

No, once the stream is started, ALSA expects the device to run by itself
(if not, the driver has to use timers).


Regards,
Clemens
